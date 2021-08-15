package main

import (
	"encoding/json"
	"io/ioutil"
	"log"
	"net"
	"net/http"
	"strings"
)

var (
	err          error
	analysisList analysis
	analysisFile = "analysis.json"
)

// The blacklist of the user's IP address.
type analysis struct {
	Abuse         []string `json:"abuse"`
	Anonymizers   []string `json:"anonymizers"`
	Attacks       []string `json:"attacks"`
	Malware       []string `json:"malware"`
	Organizations []string `json:"organizations"`
	Reputation    []string `json:"reputation"`
	Spam          []string `json:"spam"`
}

func init() {
	// Load the json files
	content, err := ioutil.ReadFile(analysisFile)
	if err != nil {
		log.Println(err)
	}
	// Parse the json file
	err = json.Unmarshal(content, &analysisList)
	if err != nil {
		log.Println(err)
	}
}

func main() {
	// The traffic should be directed to the appropriate function.
	http.HandleFunc("/", jsonResponse)
	// On port 8080, listen and serve.
	err = http.ListenAndServe(":8080", nil)
	// If something goes wrong, throw an error.
	if err != nil {
		log.Println(err)
	}
}

func jsonResponse(httpWriter http.ResponseWriter, httpRequest *http.Request) {
	if httpRequest.URL.Path == "/" {
		// Set the proper headers.
		httpWriter.Header().Set("Content-Type", "application/json")
		httpWriter.WriteHeader(http.StatusOK)
		// To add the network json object answer.
		type networkResponse struct {
			IP        net.IP   `json:"ip"`
			ReverseIP []net.IP `json:"reverse"`
			Hostname  []string `json:"hostname"`
		}
		data := networkResponse{
			IP:        getUserIP(httpRequest),
			ReverseIP: getReverseIP(getUserIP(httpRequest).String()),
			Hostname:  getHostname(getUserIP(httpRequest).String()),
		}
		// To add the device json object answer.
		type deviceResponse struct {
			UserAgent  string `json:"user_agent"`
			Accept     string `json:"accept"`
			Connection string `json:"connection"`
			Host       string `json:"host"`
			Cache      string `json:"cache"`
			AcceptEnc  string `json:"accept_encoding"`
		}
		device := deviceResponse{
			UserAgent:  getUserAgent(httpRequest),
			Accept:     getUserAccept(httpRequest),
			Connection: getConnectionType(httpRequest),
			Host:       getUserHost(httpRequest),
			Cache:      getCacheControl(httpRequest),
			AcceptEnc:  getAcceptEncoding(httpRequest),
		}
		// The analysis json object.
		type analysisResponse struct {
			Abuse         bool `json:"abuse"`
			Anonymizers   bool `json:"anonymizers"`
			Attacks       bool `json:"attacks"`
			Malware       bool `json:"malware"`
			Organizations bool `json:"organizations"`
			Reputation    bool `json:"reputation"`
			Spam          bool `json:"spam"`
		}
		analysis := analysisResponse{
			Abuse:         isInBlackList(data.IP.String(), "abuse"),
			Anonymizers:   isInBlackList(data.IP.String(), "anonymizers"),
			Attacks:       isInBlackList(data.IP.String(), "attacks"),
			Malware:       isInBlackList(data.IP.String(), "malware"),
			Organizations: isInBlackList(data.IP.String(), "organizations"),
			Reputation:    isInBlackList(data.IP.String(), "reputation"),
			Spam:          isInBlackList(data.IP.String(), "spam"),
		}
		// Wrap up the entire response in a new response.
		type dataTypes struct {
			Network  networkResponse  `json:"network"`
			Device   deviceResponse   `json:"device"`
			Analysis analysisResponse `json:"analysis"`
		}
		responseData := dataTypes{
			Network:  data,
			Device:   device,
			Analysis: analysis,
		}
		// Convert the data to json and return it.
		payloadBytes, err := json.Marshal(responseData)
		if err != nil {
			log.Println(err)
		}
		httpWriter.Write(payloadBytes)
	} else {
		http.HandleFunc(httpRequest.URL.Path, handleAllErrors)
	}
}

// Get the IP address of the server's connected user.
func getUserIP(httpServer *http.Request) net.IP {
	var userIP string
	if len(httpServer.Header.Get("CF-Connecting-IP")) > 1 {
		userIP = httpServer.Header.Get("CF-Connecting-IP")
		return net.ParseIP(strings.Split(userIP, ":")[0])
	} else if len(httpServer.Header.Get("X-Forwarded-For")) > 1 {
		userIP = httpServer.Header.Get("X-Forwarded-For")
		return net.ParseIP(strings.Split(userIP, ":")[0])
	} else if len(httpServer.Header.Get("X-Real-IP")) > 1 {
		userIP = httpServer.Header.Get("X-Real-IP")
		return net.ParseIP(strings.Split(userIP, ":")[0])
	} else {
		userIP = httpServer.RemoteAddr
		return net.ParseIP(strings.Split(userIP, ":")[0])
	}
}

// Get the user's reverse IP address.
func getReverseIP(host string) []net.IP {
	reverseIP, err := net.LookupIP(host)
	if err != nil {
		log.Println(err)
	}
	return reverseIP
}

// Get the user's hostname.
func getHostname(host string) []string {
	tempHostNames, err := net.LookupAddr(host)
	if err != nil {
		log.Println(err)
	}
	var hostname []string
	for _, host := range tempHostNames {
		hostnameRemovedSuffix := strings.TrimSuffix(host, ".")
		hostname = append(hostname, hostnameRemovedSuffix)
	}
	return hostname
}

// Get the user's device info.
func getUserAgent(httpServer *http.Request) string {
	return httpServer.Header.Get("User-Agent")
}

// Get the user's device info.
func getUserAccept(httpServer *http.Request) string {
	return httpServer.Header.Get("Accept")
}

// Get the device connection type.
func getConnectionType(httpServer *http.Request) string {
	return httpServer.Header.Get("Connection")
}

// Get the user connected host info.
func getUserHost(httpServer *http.Request) string {
	return httpServer.Header.Get("Host")
}

// Get the user connected Cache-Control header.
func getCacheControl(httpServer *http.Request) string {
	return httpServer.Header.Get("Cache-Control")
}

// Get the user accept encodings header.
func getAcceptEncoding(httpServer *http.Request) string {
	return httpServer.Header.Get("Accept-Encoding")
}

// Check if the IP address is in the blacklist.
func isInBlackList(ip string, blacklistType string) bool {
	switch blacklistType {
	case "abuse":
		for _, ips := range analysisList.Abuse {
			if ips == ip {
				return true
			}
		}
	case "anonymizers":
		for _, ips := range analysisList.Anonymizers {
			if ips == ip {
				return true
			}
		}
	case "attacks":
		for _, ips := range analysisList.Attacks {
			if ips == ip {
				return true
			}
		}
	case "malware":
		for _, ips := range analysisList.Malware {
			if ips == ip {
				return true
			}
		}
	case "organizations":
		for _, ips := range analysisList.Organizations {
			if ips == ip {
				return true
			}
		}
	case "reputation":
		for _, ips := range analysisList.Reputation {
			if ips == ip {
				return true
			}
		}
	case "spam":
		for _, ips := range analysisList.Spam {
			if ips == ip {
				return true
			}
		}
	}
	return false
}

func handleAllErrors(httpWriter http.ResponseWriter, r *http.Request) {
	// Set the header to status not found.
	httpWriter.WriteHeader(http.StatusNotFound)
	// Set the content type to application/json.
	httpWriter.Header().Set("Content-Type", "application/json")
	// Set the body to an error message.
	type errorMessage struct {
		Code    int    `json:"code"`
		Message string `json:"message"`
	}
	errorMsg := errorMessage{
		Code:    http.StatusNotFound,
		Message: "Resource not found",
	}
	// Wrap the error in a error object.
	type jsonError struct {
		Error errorMessage `json:"error"`
	}
	// The content of the error object.
	jsonReturn := jsonError{
		Error: errorMsg,
	}
	// Marshal the error message to JSON.
	errorJsonMessage, err := json.Marshal(jsonReturn)
	// Log the error if there is one.
	if err != nil {
		log.Println(err)
	}
	// Write the JSON error message.
	httpWriter.Write(errorJsonMessage)
}
