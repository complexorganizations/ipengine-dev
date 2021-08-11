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
	// Route to the clientPersonalIP function
	http.HandleFunc("/", clientPersonalIP)
	// Listen and serve on port 8080.
	err = http.ListenAndServe(":8080", nil)
	// Return an error if something went wrong
	if err != nil {
		log.Println(err)
	}
}

// The content to write to the response
func clientPersonalIP(writer http.ResponseWriter, req *http.Request) {
	// Type of the response
	type response struct {
		IP        net.IP   `json:"ip"`
		ReverseIP []net.IP `json:"reverse"`
		Hostname  []string `json:"hostname"`
	}
	data := response{
		IP:        getUserIP(req),
		ReverseIP: getReverseIP(getUserIP(req).String()),
		Hostname:  getHostname(getUserIP(req).String()),
	}
	// Convert the data into json format.
	payloadBytes, err := json.Marshal(data)
	if err != nil {
		log.Println(err)
	}
	fmt.Fprintf(writer, "%s", payloadBytes)
}

// Get the ip of the user thats connected to the server
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

// Get the reverse ip of the user
func getReverseIP(host string) []net.IP {
	reverseIP, err := net.LookupIP(host)
	if err != nil {
		log.Println(err)
	}
	return reverseIP
}

// Get the hostname of the user
func getHostname(host string) []string {
	hostname, err := net.LookupAddr(host)
	if err != nil {
		log.Println(err)
	}
	return hostname
}
