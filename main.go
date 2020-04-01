package main

import (
	"encoding/json"
	"net"
	"net/http"
)

func main() {
	http.HandleFunc("/", ExampleHandler)
	if err := http.ListenAndServe(":8080", nil); err != nil {
		panic(err)
	}
}

func ExampleHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Add("Content-Type", "application/json")

	resp := map[string]interface{}{
		"ip":         GetIP(r),
		"user_agent": r.Header.Get("User-Agent"),
	}
	hostname, err := getHostName()
	if err != nil {
		resp["hostname"] = hostname
	}

	b, _ := json.Marshal(resp)

	w.Write(b)
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

func getHostName() ([]string, error) {
	host, err := net.LookupAddr("127.0.0.1")
	return host, err
}
