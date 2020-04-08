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
	niler := func(v string) interface{} {
		if v == "" {
			return "null"
		}
		return v
	}
	w.Header().Add("Content-Type", "application/json")

	hostname := GetHostName(r.Header.Get("X-Forwarded-For"))
	reverseIp := GetReverseIp(hostname)

	resp, _ := json.MarshalIndent(map[string]interface{}{
		"ip":                        niler(r.Header.Get("X-Forwarded-For")),
		"hostname":                  niler(hostname),
		"reverse_hostname":          niler(reverseIp),
		"user_agent":                niler(r.Header.Get("User-Agent")),
	}, "", "  ")

	w.Write(resp)
}

func GetHostName(ip string) string {
	host, err := net.LookupAddr(ip)
	if err != nil {
		return ""
	}
	return host[0]
}

func GetReverseIp(host string) string {
	addr, err := net.LookupIP(host)
	if err == nil {
		return addr[0].String()
	}
	return ""
}
