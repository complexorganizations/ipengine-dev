package main

import (
	"bufio"
	"bytes"
	"compress/gzip"
	"encoding/json"
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
	// Get all the updates.
	urlPath := []string{
		"https://raw.githubusercontent.com/complexorganizations/ip-blocklists/main/assets/abuse",
		"https://raw.githubusercontent.com/complexorganizations/ip-blocklists/main/assets/anonymizers",
		"https://raw.githubusercontent.com/complexorganizations/ip-blocklists/main/assets/attacks",
		"https://raw.githubusercontent.com/complexorganizations/ip-blocklists/main/assets/malware",
		"https://raw.githubusercontent.com/complexorganizations/ip-blocklists/main/assets/organizations",
		"https://raw.githubusercontent.com/complexorganizations/ip-blocklists/main/assets/reputation",
		"https://raw.githubusercontent.com/complexorganizations/ip-blocklists/main/assets/spam",
		"https://raw.githubusercontent.com/complexorganizations/ip-blocklists/main/assets/unroutable",
	}
	for _, url := range urlPath {
		response, err := http.Get(url)
		if err != nil {
			log.Println(err)
		}
		scanner := bufio.NewScanner(response.Body)
		scanner.Split(bufio.ScanLines)
		switch url {
		case "https://raw.githubusercontent.com/complexorganizations/ip-blocklists/main/assets/abuse":
			for scanner.Scan() {
				abuseIPRange = append(abuseIPRange, scanner.Text())
			}
		case "https://raw.githubusercontent.com/complexorganizations/ip-blocklists/main/assets/anonymizers":
			for scanner.Scan() {
				anonymizersIPRange = append(anonymizersIPRange, scanner.Text())
			}
		case "https://raw.githubusercontent.com/complexorganizations/ip-blocklists/main/assets/attacks":
			for scanner.Scan() {
				attacksIPRange = append(attacksIPRange, scanner.Text())
			}
		case "https://raw.githubusercontent.com/complexorganizations/ip-blocklists/main/assets/malware":
			for scanner.Scan() {
				malwareIPRange = append(malwareIPRange, scanner.Text())
			}
		case "https://raw.githubusercontent.com/complexorganizations/ip-blocklists/main/assets/organizations":
			for scanner.Scan() {
				organizationsIPRange = append(organizationsIPRange, scanner.Text())
			}
		case "https://raw.githubusercontent.com/complexorganizations/ip-blocklists/main/assets/reputation":
			for scanner.Scan() {
				reputationIPRange = append(reputationIPRange, scanner.Text())
			}
		case "https://raw.githubusercontent.com/complexorganizations/ip-blocklists/main/assets/spam":
			for scanner.Scan() {
				spamIPRange = append(spamIPRange, scanner.Text())
			}
		case "https://raw.githubusercontent.com/complexorganizations/ip-blocklists/main/assets/unroutable":
			for scanner.Scan() {
				unroutableIPRange = append(unroutableIPRange, scanner.Text())
			}
		}
		response.Body.Close()
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
			Abuse          bool `json:"abuse"`
			Anonymizers    bool `json:"anonymizers"`
			Attacks        bool `json:"attacks"`
			Geolocation    bool `json:"geolocation"`
			Malware        bool `json:"malware"`
			Organizations  bool `json:"organizations"`
			Reputation     bool `json:"reputation"`
			Spam           bool `json:"spam"`
			Unroutable     bool `json:"unroutable"`
			Unspecified    bool `json:"unspecified"`
			Private        bool `json:"private"`
			Multicast      bool `json:"multicast"`
			Loopback       bool `json:"loopback"`
			LocalUnicast   bool `json:"local_unicast"`
			LocalMulticast bool `json:"local_multicast"`
			InterfaceLocalMulticast bool `json:"interface_local_multicast"`
			GlobalUnicast bool `json:"global_unicast"`
		}
		analysis := analysisResponse{
			Abuse:          isInBlackList(requestedIP, "abuse"),
			Anonymizers:    isInBlackList(requestedIP, "anonymizers"),
			Attacks:        isInBlackList(requestedIP, "attacks"),
			Geolocation:    isInBlackList(requestedIP, "geolocation"),
			Malware:        isInBlackList(requestedIP, "malware"),
			Organizations:  isInBlackList(requestedIP, "organizations"),
			Reputation:     isInBlackList(requestedIP, "reputation"),
			Spam:           isInBlackList(requestedIP, "spam"),
			Unroutable:     isInBlackList(requestedIP, "unroutable"),
			Unspecified:    unspecifiedIPCheck(requestedIP),
			Private:        isPrivateIP(requestedIP),
			Multicast:      isMulticastIP(requestedIP),
			Loopback:       isLoopbackIP(requestedIP),
			LocalUnicast:   isLocalUnicastIP(requestedIP),
			LocalMulticast: isLocalMulticastIP(requestedIP),
			InterfaceLocalMulticast: isInterfaceLocalMulticastIP(requestedIP),
			GlobalUnicast: isGlobalUnicastIP(requestedIP),
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
	httpWriter.Header().Set("Content-Encoding", "gzip")
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
	// Compress the information.
	var byteBuffer bytes.Buffer
	gzipWriter := gzip.NewWriter(&byteBuffer)
	gzipWriter.Write(errorJsonMessage)
	gzipWriter.Close()
	// Write the compressed data.
	httpWriter.Write(byteBuffer.Bytes())
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

func isLoopbackIP(ipAddress net.IP) bool {
	return ipAddress.IsLoopback()
}

func isLocalUnicastIP(ipAddress net.IP) bool {
	return ipAddress.IsLinkLocalUnicast()
}

func isLocalMulticastIP(ipAddress net.IP) bool {
	return ipAddress.IsLinkLocalMulticast()
}

func isInterfaceLocalMulticastIP(ipAddress net.IP) bool {
	return ipAddress.IsInterfaceLocalMulticast()
}

func isGlobalUnicastIP(ipAddress net.IP) bool {
	return ipAddress.IsGlobalUnicast()
}
