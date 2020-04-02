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

	hostname := GetHostName(r.Header.Get("CF-CONNECTING-IP"))
	reverseIp := GetReverseIp(hostname)

	resp, _ := json.MarshalIndent(map[string]interface{}{
		"accept":                    r.Header.Get("Accept"),
		"accept_encoding":           r.Header.Get("Accept-Encoding"),
		"accept_language":           r.Header.Get("Accept-Language"),
		"cache_control":             r.Header.Get("Cache-Control"),
		"dnt":                       r.Header.Get("DNT"),
		"ip":                        r.Header.Get("CF-CONNECTING-IP"),
		"hostname":                  hostname,
		"reverse_ip":                reverseIp,
		"referer":                   r.Header.Get("Referer"),
		"sec_fetch_dest":            r.Header.Get("Sec-Fetch-Dest"),
		"sec_fetch_mode":            r.Header.Get("Sec-Fetch-Mode"),
		"sec_fetch_user":            r.Header.Get("Sec-Fetch-User"),
		"sec_fetch_site":            r.Header.Get("Sec-Fetch-Site"),
		"upgrade_insecure_requests": r.Header.Get("Upgrade-Insecure-Requests"),
		"user_agent":                r.Header.Get("User-Agent"),
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
