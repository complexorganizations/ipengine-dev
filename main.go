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

	hostname := GetHostName(r.Header.Get("CF-CONNECTING-IP"))
	reverseIp := GetReverseIp(hostname)

	resp, _ := json.MarshalIndent(map[string]interface{}{
		"accept":                    niler(r.Header.Get("Accept")),
		"accept_encoding":           niler(r.Header.Get("Accept-Encoding")),
		"accept_language":           niler(r.Header.Get("Accept-Language")),
		"cache_control":             niler(r.Header.Get("Cache-Control")),
		"dnt":                       niler(r.Header.Get("DNT")),
		"ip":                        niler(r.Header.Get("CF-CONNECTING-IP")),
		"hostname":                  niler(hostname),
		"reverse_hostname":          niler(reverseIp),
		"referer":                   niler(r.Header.Get("Referer")),
		"sec_fetch_dest":            niler(r.Header.Get("Sec-Fetch-Dest")),
		"sec_fetch_mode":            niler(r.Header.Get("Sec-Fetch-Mode")),
		"sec_fetch_user":            niler(r.Header.Get("Sec-Fetch-User")),
		"sec_fetch_site":            niler(r.Header.Get("Sec-Fetch-Site")),
		"upgrade_insecure_requests": niler(r.Header.Get("Upgrade-Insecure-Requests")),
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
