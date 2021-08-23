package main

import (
	"bytes"
	"compress/gzip"
	"encoding/json"
	"io/ioutil"
	"log"
	"math/big"
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
	Geolocation   []string `json:"geolocation"`
	Malware       []string `json:"malware"`
	Organizations []string `json:"organizations"`
	Reputation    []string `json:"reputation"`
	Spam          []string `json:"spam"`
	Unroutable    []string `json:"unroutable"`
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
	http.HandleFunc("/error", handleAllErrors)
	// On port 8080, listen and serve.
	err = http.ListenAndServe(":8080", nil)
	// If something goes wrong, throw an error.
	if err != nil {
		log.Println(err)
	}
}

func jsonResponse(httpWriter http.ResponseWriter, httpRequest *http.Request) {
	if httpRequest.URL.Path == "/" && httpRequest.Method == "GET" {
		// Set the proper headers.
		httpWriter.Header().Set("Content-Type", "application/json")
		httpWriter.Header().Set("Content-Encoding", "gzip")
		httpWriter.Header().Set("Access-Control-Allow-Methods", "GET")
		httpWriter.Header().Set("Access-Control-Max-Age", "7776000")
		httpWriter.WriteHeader(http.StatusOK)
		// To add the network json object answer.
		type networkResponse struct {
			IP        net.IP   `json:"ip"`
			Type      string   `json:"type"`
			Decimal   *big.Int `json:"decimal"`
			ReverseIP []net.IP `json:"reverse"`
			Hostname  []string `json:"hostname"`
		}
		data := networkResponse{
			IP:        getUserIP(httpRequest),
			Type:      getIPType(getUserIP(httpRequest)),
			Decimal:   ipToDecimal(getUserIP(httpRequest)),
			ReverseIP: getReverseIP(getUserIP(httpRequest).String()),
			Hostname:  getHostname(getUserIP(httpRequest).String()),
		}
		// To add the device json object answer.
		type deviceResponse struct {
			UserAgent string `json:"user_agent"`
			Accept    string `json:"accept"`
			Cache     string `json:"cache"`
			AcceptEnc string `json:"accept_encoding"`
		}
		device := deviceResponse{
			UserAgent: getUserAgent(httpRequest),
			Accept:    getUserAccept(httpRequest),
			Cache:     getCacheControl(httpRequest),
			AcceptEnc: getAcceptEncoding(httpRequest),
		}
		// The analysis json object.
		type analysisResponse struct {
			Abuse         bool `json:"abuse"`
			Anonymizers   bool `json:"anonymizers"`
			Attacks       bool `json:"attacks"`
			Geolocation   bool `json:"geolocation"`
			Malware       bool `json:"malware"`
			Organizations bool `json:"organizations"`
			Reputation    bool `json:"reputation"`
			Spam          bool `json:"spam"`
			Unroutable    bool `json:"unroutable"`
		}
		analysis := analysisResponse{
			Abuse:         isInBlackList(data.IP, "abuse"),
			Anonymizers:   isInBlackList(data.IP, "anonymizers"),
			Attacks:       isInBlackList(data.IP, "attacks"),
			Geolocation:   isInBlackList(data.IP, "geolocation"),
			Malware:       isInBlackList(data.IP, "malware"),
			Organizations: isInBlackList(data.IP, "organizations"),
			Reputation:    isInBlackList(data.IP, "reputation"),
			Spam:          isInBlackList(data.IP, "spam"),
			Unroutable:    isInBlackList(data.IP, "unroutable"),
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
		// Compress the data.
		var byteBuffer bytes.Buffer
		gzipWriter := gzip.NewWriter(&byteBuffer)
		gzipWriter.Write(payloadBytes)
		gzipWriter.Close()
		// Write the compressed data to the httpWriter.
		httpWriter.Write(byteBuffer.Bytes())
	} else {
		http.Redirect(httpWriter, httpRequest, "/error", http.StatusMovedPermanently)
	}
}

// Get the IP address of the server's connected user.
func getUserIP(httpServer *http.Request) net.IP {
	var userIP string
	if len(httpServer.Header.Get("CF-Connecting-IP")) > 1 {
		userIP = httpServer.Header.Get("CF-Connecting-IP")
		return net.ParseIP(userIP)
	} else if len(httpServer.Header.Get("X-Forwarded-For")) > 1 {
		userIP = httpServer.Header.Get("X-Forwarded-For")
		return net.ParseIP(userIP)
	} else if len(httpServer.Header.Get("X-Real-IP")) > 1 {
		userIP = httpServer.Header.Get("X-Real-IP")
		return net.ParseIP(userIP)
	} else {
		userIP = httpServer.RemoteAddr
		if strings.Contains(userIP, ":") {
			return net.ParseIP(strings.Split(userIP, ":")[0])
		} else {
			return net.ParseIP(userIP)
		}
	}
}

// Get the user's reverse IP address.
func getReverseIP(host string) []net.IP {
	reverseIP, err := net.LookupIP(host)
	if err != nil {
		log.Println(err)
	}
	if len(reverseIP) == 0 {
		return nil
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
	if len(hostname) == 0 {
		return nil
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

// Get the user connected Cache-Control header.
func getCacheControl(httpServer *http.Request) string {
	return httpServer.Header.Get("Cache-Control")
}

// Get the user accept encodings header.
func getAcceptEncoding(httpServer *http.Request) string {
	return httpServer.Header.Get("Accept-Encoding")
}

// Get the api key if the user has provided any.
func getAuthorizationHeader(httpServer *http.Request) string {
	return httpServer.Header.Get("Authorization")
}

// Check if the IP address is in the blacklist.
func isInBlackList(ip net.IP, blacklistType string) bool {
	switch blacklistType {
	case "abuse":
		if checkIfIPInRange(ip, analysisList.Abuse) {
			return true
		} else {
			return checkIPInRange(ip, analysisList.Abuse)
		}
	case "anonymizers":
		if checkIfIPInRange(ip, analysisList.Anonymizers) {
			return true
		} else {
			return checkIPInRange(ip, analysisList.Anonymizers)
		}
	case "attacks":
		if checkIfIPInRange(ip, analysisList.Attacks) {
			return true
		} else {
			return checkIPInRange(ip, analysisList.Attacks)
		}
	case "geolocation":
		if checkIfIPInRange(ip, analysisList.Geolocation) {
			return true
		} else {
			return checkIPInRange(ip, analysisList.Geolocation)
		}
	case "malware":
		if checkIfIPInRange(ip, analysisList.Malware) {
			return true
		} else {
			return checkIPInRange(ip, analysisList.Malware)
		}
	case "organizations":
		if checkIfIPInRange(ip, analysisList.Organizations) {
			return true
		} else {
			return checkIPInRange(ip, analysisList.Organizations)
		}
	case "reputation":
		if checkIfIPInRange(ip, analysisList.Reputation) {
			return true
		} else {
			return checkIPInRange(ip, analysisList.Reputation)
		}
	case "spam":
		if checkIfIPInRange(ip, analysisList.Spam) {
			return true
		} else {
			return checkIPInRange(ip, analysisList.Spam)
		}
	case "unroutable":
		if checkIfIPInRange(ip, analysisList.Unroutable) {
			return true
		} else {
			return checkIPInRange(ip, analysisList.Unroutable)
		}
	}
	return false
}

func handleAllErrors(httpWriter http.ResponseWriter, r *http.Request) {
	// Set the content type to application/json.
	httpWriter.Header().Set("Content-Type", "application/json")
	httpWriter.Header().Set("Content-Encoding", "gzip")
	httpWriter.Header().Set("Access-Control-Max-Age", "7776000")
	// Set the header to status not found.
	httpWriter.WriteHeader(http.StatusNotFound)
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
	// Compress the data.
	var byteBuffer bytes.Buffer
	gzipWriter := gzip.NewWriter(&byteBuffer)
	gzipWriter.Write(errorJsonMessage)
	gzipWriter.Close()
	// Write the compressed data to the httpWriter.
	httpWriter.Write(byteBuffer.Bytes())
}

// Determine the type of the IP.
func getIPType(ip net.IP) string {
	if strings.Contains(ip.String(), ".") {
		return "IPv4"
	} else if strings.Contains(ip.String(), ":") {
		return "IPv6"
	}
	return "Unknown"
}

// Check if a certain range of cdir contains certain ip.
func checkIfIPInRange(ip net.IP, blacklist []string) bool {
	for _, cidr := range blacklist {
		if strings.Contains(cidr, "/") {
			_, ipnet, _ := net.ParseCIDR(cidr)
			if ipnet.Contains(ip) {
				return true
			}
		}
	}
	return false
}

// Check ip in a range
func checkIPInRange(ip net.IP, completeList []string) bool {
	for _, ips := range completeList {
		if ips == ip.String() {
			return true
		}
	}
	return false
}

// Turn the ip into a decimal value.
func ipToDecimal(ip net.IP) *big.Int {
	ipToIntValue := big.NewInt(0)
	if strings.Contains(ip.String(), ".") {
		ipToIntValue.SetBytes(ip.To4())
	} else if strings.Contains(ip.String(), ":") {
		ipToIntValue.SetBytes(ip.To16())
	}
	return ipToIntValue
}
