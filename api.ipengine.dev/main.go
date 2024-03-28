package main

import (
	"bufio"
	"bytes"
	"encoding/json"
	"io"
	"log"
	"math/big"
	"net"
	"net/http"
	"strings"
)

var (
	err         error
	requestedIP net.IP
	// Instead of using the users IP address, we can use the requested IP address.
	authentication bool
	// The examination of a user's IP address.
	abuseIPRange         []string
	anonymizersIPRange   []string
	attacksIPRange       []string
	malwareIPRange       []string
	organizationsIPRange []string
	reputationIPRange    []string
	spamIPRange          []string
	unroutableIPRange    []string
)

func init() {
	// Update all the local IP address ranges.
	updateLocalIPRanges()
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
	// Check to see whether they requested a different IP address than theirs, and if so, use that address.
	authentication = len(getRequestedIP(httpRequest)) >= 1 && len(getAuthorizationHeader(httpRequest)) >= 1
	if authentication {
		requestedIP = getRequestedIP(httpRequest)
	} else {
		requestedIP = getUserIP(httpRequest)
	}
	if httpRequest.URL.Path == "/" && httpRequest.Method == "GET" && checkIP(requestedIP.String()) {
		// Set the proper headers.
		httpWriter.Header().Set("Content-Type", "application/json")
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
			IP:        requestedIP,
			Type:      getIPType(requestedIP),
			Decimal:   ipToDecimal(requestedIP),
			ReverseIP: getReverseIP(requestedIP.String()),
			Hostname:  getHostname(requestedIP.String()),
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
			Abuse                   bool `json:"abuse"`
			Anonymizers             bool `json:"anonymizers"`
			Attacks                 bool `json:"attacks"`
			Geolocation             bool `json:"geolocation"`
			Malware                 bool `json:"malware"`
			Organizations           bool `json:"organizations"`
			Reputation              bool `json:"reputation"`
			Spam                    bool `json:"spam"`
			Unroutable              bool `json:"unroutable"`
			Unspecified             bool `json:"unspecified"`
			Private                 bool `json:"private"`
			Multicast               bool `json:"multicast"`
			Loopback                bool `json:"loopback"`
			LocalUnicast            bool `json:"local_unicast"`
			LocalMulticast          bool `json:"local_multicast"`
			InterfaceLocalMulticast bool `json:"interface_local_multicast"`
			GlobalUnicast           bool `json:"global_unicast"`
		}
		analysis := analysisResponse{
			Abuse:                   isInBlackList(requestedIP, "abuse"),
			Anonymizers:             isInBlackList(requestedIP, "anonymizers"),
			Attacks:                 isInBlackList(requestedIP, "attacks"),
			Geolocation:             isInBlackList(requestedIP, "geolocation"),
			Malware:                 isInBlackList(requestedIP, "malware"),
			Organizations:           isInBlackList(requestedIP, "organizations"),
			Reputation:              isInBlackList(requestedIP, "reputation"),
			Spam:                    isInBlackList(requestedIP, "spam"),
			Unroutable:              isInBlackList(requestedIP, "unroutable"),
			Unspecified:             unspecifiedIPCheck(requestedIP),
			Private:                 isPrivateIP(requestedIP),
			Multicast:               isMulticastIP(requestedIP),
			Loopback:                isLoopbackIP(requestedIP),
			LocalUnicast:            isLocalUnicastIP(requestedIP),
			LocalMulticast:          isLocalMulticastIP(requestedIP),
			InterfaceLocalMulticast: isInterfaceLocalMulticastIP(requestedIP),
			GlobalUnicast:           isGlobalUnicastIP(requestedIP),
		}
		var responseData interface{}
		if authentication {
			// Wrap up the entire response in a new response.
			type dataTypes struct {
				Network  networkResponse  `json:"network"`
				Analysis analysisResponse `json:"analysis"`
			}
			responseData = dataTypes{
				Network:  data,
				Analysis: analysis,
			}
		} else {
			type dataTypes struct {
				Network  networkResponse  `json:"network"`
				Device   deviceResponse   `json:"device"`
				Analysis analysisResponse `json:"analysis"`
			}
			responseData = dataTypes{
				Network:  data,
				Device:   device,
				Analysis: analysis,
			}
		}
		// Convert the data to json and return it.
		payloadBytes, err := json.Marshal(responseData)
		if err != nil {
			log.Println(err)
		}
		// Write the compressed data to the httpWriter.
		httpWriter.Write(payloadBytes)
	} else {
		http.Redirect(httpWriter, httpRequest, "/error", http.StatusMovedPermanently)
	}
}

// Get the IP address of the server's connected user.
func getUserIP(httpServer *http.Request) net.IP {
	if len(httpServer.Header.Get("CF-Connecting-IP")) > 1 {
		return net.ParseIP(httpServer.Header.Get("CF-Connecting-IP"))
	} else if len(httpServer.Header.Get("X-Forwarded-For")) > 1 {
		return net.ParseIP(httpServer.Header.Get("X-Forwarded-For"))
	} else if len(httpServer.Header.Get("X-Real-IP")) > 1 {
		return net.ParseIP(httpServer.Header.Get("X-Real-IP"))
	} else {
		returnIP, _, _ := net.SplitHostPort(httpServer.RemoteAddr)
		return net.ParseIP(returnIP)
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
		hostname = append(hostname, strings.TrimSuffix(host, "."))
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

// Get the requested IP address.
func getRequestedIP(httpServer *http.Request) net.IP {
	return net.ParseIP(httpServer.Header.Get("Requested-Ip"))
}

// Check if the IP address is in the blacklist.
func isInBlackList(ip net.IP, blacklistType string) bool {
	switch blacklistType {
	case "abuse":
		if checkIfIPInRange(ip, abuseIPRange) {
			return true
		}
	case "anonymizers":
		if checkIfIPInRange(ip, anonymizersIPRange) {
			return true
		}
	case "attacks":
		if checkIfIPInRange(ip, attacksIPRange) {
			return true
		}
	case "malware":
		if checkIfIPInRange(ip, malwareIPRange) {
			return true
		}
	case "organizations":
		if checkIfIPInRange(ip, organizationsIPRange) {
			return true
		}
	case "reputation":
		if checkIfIPInRange(ip, reputationIPRange) {
			return true
		}
	case "spam":
		if checkIfIPInRange(ip, spamIPRange) {
			return true
		}
	case "unroutable":
		if checkIfIPInRange(ip, unroutableIPRange) {
			return true
		}
	}
	return false
}

func handleAllErrors(httpWriter http.ResponseWriter, r *http.Request) {
	// Make sure you've got the right headers in place.
	httpWriter.Header().Set("Content-Type", "application/json")
	httpWriter.Header().Set("Access-Control-Max-Age", "7776000")
	httpWriter.WriteHeader(http.StatusNotFound)
	// Set the body of the message to an error message.
	type errorMessage struct {
		Code    int    `json:"code"`
		Message string `json:"message"`
	}
	errorMsg := errorMessage{
		Code:    http.StatusNotFound,
		Message: "Resource not found",
	}
	// Make an error object out of the error.
	type jsonError struct {
		Error errorMessage `json:"error"`
	}
	// The error object's contents.
	jsonReturn := jsonError{
		Error: errorMsg,
	}
	// JSON should be used to send the error message.
	errorJsonMessage, err := json.Marshal(jsonReturn)
	// Log the error if there is one.
	if err != nil {
		log.Println(err)
	}
	// Write the data.
	httpWriter.Write(errorJsonMessage)
}

// Determine the IP address's type.
func getIPType(ip net.IP) string {
	if strings.Contains(ip.String(), ".") {
		return "IPv4"
	} else if strings.Contains(ip.String(), ":") {
		return "IPv6"
	}
	return "Unknown"
}

// Check if a specific cdir range contains a specific ip.
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

// Convert the IP address to a decimal number.
func ipToDecimal(ip net.IP) *big.Int {
	ipToIntValue := big.NewInt(0)
	if strings.Contains(ip.String(), ".") {
		ipToIntValue.SetBytes(ip.To4())
	} else if strings.Contains(ip.String(), ":") {
		ipToIntValue.SetBytes(ip.To16())
	}
	return ipToIntValue
}

// Verify that the IP address is correct.
func checkIP(ip string) bool {
	return net.ParseIP(ip) != nil
}

// Check if the IP address is unspecified
func unspecifiedIPCheck(ipAddress net.IP) bool {
	return ipAddress.IsUnspecified()
}

// Check if the IP is a private IP
func isPrivateIP(ipAddress net.IP) bool {
	return ipAddress.IsPrivate()
}

// Check if the ip is a multicast IP
func isMulticastIP(ipAddress net.IP) bool {
	return ipAddress.IsMulticast()
}

// Check if the ip is a loopback ip.
func isLoopbackIP(ipAddress net.IP) bool {
	return ipAddress.IsLoopback()
}

// Checks if the ip is a local unicast ip
func isLocalUnicastIP(ipAddress net.IP) bool {
	return ipAddress.IsLinkLocalUnicast()
}

// Check if the ip is a local multicast ip
func isLocalMulticastIP(ipAddress net.IP) bool {
	return ipAddress.IsLinkLocalMulticast()
}

// Check if the ip is a interface local multicast ip
func isInterfaceLocalMulticastIP(ipAddress net.IP) bool {
	return ipAddress.IsInterfaceLocalMulticast()
}

// Check if the IP address is a global unicast IP
func isGlobalUnicastIP(ipAddress net.IP) bool {
	return ipAddress.IsGlobalUnicast()
}

func updateLocalIPRanges() {
	// Get all the updates.
	var urlPath = map[string]string{
		"https://raw.githubusercontent.com/complexorganizations/network-database/main/assets/abuse":         "abuse",
		"https://raw.githubusercontent.com/complexorganizations/network-database/main/assets/anonymizers":   "anonymizers",
		"https://raw.githubusercontent.com/complexorganizations/network-database/main/assets/attacks":       "attacks",
		"https://raw.githubusercontent.com/complexorganizations/network-database/main/assets/malware":       "malware",
		"https://raw.githubusercontent.com/complexorganizations/network-database/main/assets/organizations": "organizations",
		"https://raw.githubusercontent.com/complexorganizations/network-database/main/assets/reputation":    "reputation",
		"https://raw.githubusercontent.com/complexorganizations/network-database/main/assets/spam":          "spam",
		"https://raw.githubusercontent.com/complexorganizations/network-database/main/assets/unroutable":    "unroutable",
	}
	for key, value := range urlPath {
		switch value {
		case "abuse":
			abuseIPRange = getDataFromURL(key, abuseIPRange)
		case "anonymizers":
			anonymizersIPRange = getDataFromURL(key, anonymizersIPRange)
		case "attacks":
			attacksIPRange = getDataFromURL(key, attacksIPRange)
		case "malware":
			malwareIPRange = getDataFromURL(key, malwareIPRange)
		case "organizations":
			organizationsIPRange = getDataFromURL(key, organizationsIPRange)
		case "reputation":
			reputationIPRange = getDataFromURL(key, reputationIPRange)
		case "spam":
			spamIPRange = getDataFromURL(key, spamIPRange)
		case "unroutable":
			unroutableIPRange = getDataFromURL(key, unroutableIPRange)
		}
	}
}

// Send a http get request to a given url and return the data from that url.
func getDataFromURL(uri string, sliceValue []string) []string {
	response, err := http.Get(uri)
	if err != nil {
		log.Println(err)
	}
	body, err := io.ReadAll(response.Body)
	if err != nil {
		log.Println(err)
	}
	scanner := bufio.NewScanner(bytes.NewReader(body))
	scanner.Split(bufio.ScanLines)
	for scanner.Scan() {
		sliceValue = append(sliceValue, scanner.Text())
	}
	err = response.Body.Close()
	if err != nil {
		log.Println(err)
	}
	return sliceValue
}
