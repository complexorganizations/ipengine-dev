package main

import (
	"encoding/json"
	"errors"
	"log"
	"net"
	"net/http"
	"os"
	"strings"
)

type Info struct {
	Ip              string `json:"ip"`
	Hostname        string `json:"hostname"`
	ReverseIp       string `json:"reverse_ip"`
	ReverseHostname string `json:"reverse_hostname"`
}

func main() {
	//logger
	err := initLogger()
	if err != nil {
		log.Fatal(err.Error())
	}
	//router
	r := http.NewServeMux()
	//routes
	r.HandleFunc("/ip/", ipHandler)
	//http server
	log.Println("api started...")
	err = http.ListenAndServe(":8080", r)
	log.Fatal(err.Error())
}

func initLogger() error {
	//output (fileMode: -rw-r--r--)
	lf, err := os.OpenFile("logs.log", os.O_CREATE|os.O_APPEND|os.O_WRONLY, 0644)
	if err != nil {
		log.Printf("debug: %s\n", err.Error())
		return errors.New("initializing logger failed!")
	}
	log.SetOutput(lf)
	//flags
	log.SetFlags(log.LstdFlags | log.Lshortfile)
	return nil
}

func ipHandler(w http.ResponseWriter, r *http.Request) {
	//ip parameter
	ip, err := getIpParam(r)
	if err != nil {
		log.Printf("debug: %s\n", err.Error())
		http.Error(w, http.StatusText(http.StatusNotFound), http.StatusNotFound)
		return
	}
	//info
	i, err := getInfo(ip, r)
	if err != nil {
		log.Printf("error: %s\n", err.Error())
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
		return
	}
	//response
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	err = json.NewEncoder(w).Encode(i)
	if err != nil {
		log.Printf("debug: %s\n", err.Error())
	}
}

func getIpParam(r *http.Request) (string, error) {
	//url path: /ip/:ip
	ip := r.URL.Path[4:]
	i := strings.Index(ip, "/")
	if i == -1 {
		return ip, nil
	} else {
		return "", errors.New("getting ip parameter failed!")
	}
}

func getInfo(ip string, r *http.Request) (*Info, error) {
	//hostname
	h, err := getHostname(ip)
	if err != nil {
		return nil, err
	}
	//reverse ip
	rip := getReverseIp(r)
	//reverse hostname
	rh, err := getHostname(rip)
	if err != nil {
		return nil, err
	}
	//who is
	//...
	i := Info{
		Ip:              ip,
		Hostname:        h,
		ReverseIp:       rip,
		ReverseHostname: rh,
	}
	return &i, nil
}

func getHostname(ip string) (string, error) {
	h, err := net.LookupAddr(ip)
	if err != nil {
		log.Printf("debug: %s\n", err.Error())
		return "", errors.New("getting hostname failed!")
	}
	return h[0], nil
}

func getReverseIp(r *http.Request) string {
	ff := r.Header.Get("X-FORWARDED-FOR")
	if ff != "" {
		return ff
	}
	//fall back to request's remote address
	ip := getIp(r.RemoteAddr)
	return ip
}

func getIp(remoteAddress string) string {
	i := strings.Index(remoteAddress, ":")
	return remoteAddress[0:i]
}
