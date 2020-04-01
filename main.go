package main

import (
	"encoding/json"
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
	resp, _ := json.Marshal(map[string]string{
		"accept":                    r.Header.Get("Accept"),
		"accept_encoding":           r.Header.Get("Accept-Encoding"),
		"accept_language":           r.Header.Get("Accept-Language"),
		"cache_control":             r.Header.Get("Cache-Control"),
		"dnt":                       r.Header.Get("DNT"),
		"ip":                        r.Header.Get("CF-CONNECTING-IP"),
		"referer":                   r.Header.Get("Referer"),
		"sec_fetch_dest":            r.Header.Get("Sec-Fetch-Dest"),
		"sec_fetch_mode":            r.Header.Get("Sec-Fetch-Mode"),
		"sec_fetch_user":            r.Header.Get("Sec-Fetch-User"),
		"sec_fetch_site":            r.Header.Get("Sec-Fetch-Site"),
		"upgrade_insecure_requests": r.Header.Get("Upgrade-Insecure-Requests"),
		"user_agent":                r.Header.Get("User-Agent"),
	})
	w.Write(resp)
}
