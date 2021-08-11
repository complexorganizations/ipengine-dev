package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net"
	"net/http"
	"os"
	"strings"
)

var (
	blackList    []string
	err          error
	analysisFile = "analysis.json"
)

func init() {
	// Load the json files
	content, err := os.ReadFile(analysisFile)
	if err != nil {
		log.Println(err)
	}
	// Parse the json file
	err = json.Unmarshal(content, &blackList)
	if err != nil {
		log.Println(err)
	}
}

func main() {
	// The traffic should be directed to the appropriate function.
	http.HandleFunc("/", personalRequestWriter)
	// On port 8080, listen and serve.
	err = http.ListenAndServe(":8080", nil)
	// If something goes wrong, throw an error.
	if err != nil {
		log.Println(err)
	}
}

// The substance of the response to write
func personalRequestWriter(writer http.ResponseWriter, req *http.Request) {
	writer.Header().Set("Content-Type", "application/json")
	fmt.Fprintf(writer, "%s", jsonResponse(req))
}

func jsonResponse(httpRequest *http.Request) []byte {
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
		Abuse:         isInBlackList(data.IP.String()),
		Anonymizers:   isInBlackList(data.IP.String()),
		Attacks:       isInBlackList(data.IP.String()),
		Malware:       isInBlackList(data.IP.String()),
		Organizations: isInBlackList(data.IP.String()),
		Reputation:    isInBlackList(data.IP.String()),
		Spam:          isInBlackList(data.IP.String()),
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
	return payloadBytes
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
	hostname, err := net.LookupAddr(host)
	if err != nil {
		log.Println(err)
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
func isInBlackList(ip string) bool {
	for _, blackIP := range blackList {
		if blackIP == ip {
			return true
		}
	}
	return false
}
