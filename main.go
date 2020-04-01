package main

import (
	"encoding/json"
	"net"
	"net/http"
	"strings"
)

func main() {
	http.HandleFunc("/", ExampleHandler)
	if err := http.ListenAndServe(":8080", nil); err != nil {
		panic(err)
	}
}

func ExampleHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Add("Content-Type", "application/json")

	addr := GetIP(r)
	addrList := strings.Split(addr, ":")
	ip := addrList[0]

	resp := map[string]interface{}{
		"ip":         GetIP(r),
		"user_agent": r.Header.Get("User-Agent"),
		"accept_language": r.Header.Get("Accept-Language"),
		"accept_encoding": r.Header.Get("Accept-Encoding"),
		"accept": r.Header.Get("Accept"),
		"host": r.Header.Get("Host"),
		"referer": r.Header.Get("Referer"),
		"upgrade_insecure_requests": r.Header.Get("Upgrade-Insecure-Requests"),
		"access_control_request_method": r.Header.Get("Access-Control-Request-Method"),
	}
	hostname, err := GetHostName(ip)
	if err == nil {
		resp["hostname"] = hostname[0]
	}

	b, _ := json.Marshal(resp)

	_, _ = w.Write(b)
}

// GetIP gets a requests IP address by reading off the forwarded-for
// header (for proxies) and falls back to use the remote address.
func GetIP(r *http.Request) string {
	forwarded := r.Header.Get("CF-CONNECTING-IP")
	if forwarded != "" {
		return forwarded
	}
	return r.RemoteAddr
}

func GetHostName(ip string) ([]string, error) {
	host, err := net.LookupAddr(ip)
	return host, err
}
