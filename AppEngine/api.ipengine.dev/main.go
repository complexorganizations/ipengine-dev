package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net"
	"net/http"
	"strings"
)

var err error

func init() {
	// Load the json files
}

func main() {
	// The traffic should be directed to the appropriate function.
	http.HandleFunc("/", clientPersonalIP)
	// On port 8080, listen and serve.
	err = http.ListenAndServe(":8080", nil)
	// If something goes wrong, throw an error.
	if err != nil {
		log.Println(err)
	}
}

// The substance of the response to write
func clientPersonalIP(writer http.ResponseWriter, req *http.Request) {
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
	// Wrap up the entire response in a new response.
	type dataTypes struct {
		Network networkResponse `json:"network"`
	}
	responseData := dataTypes{
		Network: data,
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
