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
        w.Header().Add("Content-Security-Policy", "script-src 'self'; object-src 'self'")
        w.Header().Add("Referrer-Policy", "strict-origin")
        w.Header().Add("Strict-Transport-Security", "max-age=63072000; includeSubDomains; preload")
        w.Header().Add("Feature-Policy", "vibrate 'self'")
        w.Header().Add("X-Frame-Options", "SAMEORIGIN")
        w.Header().Add("X-Content-Type-Options", "nosniff")

	hostname := GetHostName(r.Header.Get("CF-Connecting-IP"))
	reverseIp := GetReverseIp(hostname)

	resp, _ := json.Marshal(map[string]interface{}{
		"success":					 niler("true"),
		"ip":                        niler(r.Header.Get("CF-Connecting-IP")),
		"hostname":                  niler(hostname),
		"reverse":                   niler(reverseIp),
		"useragent":                 niler(r.Header.Get("User-Agent")),
	})

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
