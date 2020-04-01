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
                "ip":                        r.Header.Get("CF-CONNECTING-IP"),
                "user_agent":                r.Header.Get("User-Agent"),
                "accept_language":           r.Header.Get("Accept-Language"),
                "accept_encoding":           r.Header.Get("Accept-Encoding"),
                "accept":                    r.Header.Get("Accept"),
                "referer":                   r.Header.Get("Referer"),
                "upgrade_insecure_requests": r.Header.Get("Upgrade-Insecure-Requests"),
                "cache_control":             r.Header.Get("Cache-Control"),
                "sec_fetch_site":            r.Header.Get("Sec-Fetch-Site"),
        })
        w.Write(resp)
}
