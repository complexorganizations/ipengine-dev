package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"
	"time"
)

type ArinRdapData struct {
	Handle       string `json:"handle"`
	StartAddress string `json:"startAddress"`
	EndAddress   string `json:"endAddress"`
	Name         string `json:"name"`
	Type         string `json:"type"`
	ParentHandle string `json:"parentHandle"`
	Events       []struct {
		EventAction string `json:"eventAction"`
		EventDate   string `json:"eventDate"`
	} `json:"events"`
	Entities []struct {
		Handle     string        `json:"handle"`
		VcardArray []interface{} `json:"vcardArray"`
		Events     []struct {
			EventAction string `json:"eventAction"`
			EventDate   string `json:"eventDate"`
		} `json:"events"`
		Entities []struct {
			Handle     string        `json:"handle"`
			VcardArray []interface{} `json:"vcardArray"`
			Events     []struct {
				EventAction string `json:"eventAction"`
				EventDate   string `json:"eventDate"`
			} `json:"events"`
		} `json:"entities"`
		ObjectClassName string `json:"objectClassName"`
	} `json:"entities"`
	Cidr0Cidrs []struct {
		V4Prefix string `json:"v4prefix"`
		Length   int    `json:"length"`
	} `json:"cidr0_cidrs"`
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
	r.HandleFunc("/", reverseIpHandler)
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

func reverseIpHandler(w http.ResponseWriter, r *http.Request) {
	//reverse ip
	rip := getReverseIp(r)
	returnWhoisData(rip, w)
}

func ipHandler(w http.ResponseWriter, r *http.Request) {
	//ip
	ip, err := getIpParam(r)
	if err != nil {
		log.Printf("debug: %s\n", err.Error())
		http.Error(w, http.StatusText(http.StatusNotFound), http.StatusNotFound)
		return
	}
	returnWhoisData(ip, w)
}

func returnWhoisData(ip string, w http.ResponseWriter) {
	//whois data
	c := http.Client{
		Timeout: time.Duration(time.Second * 30),
	}
	url := fmt.Sprintf("https://rdap.arin.net/registry/ip/%s.json", ip)
	r, err := c.Get(url)
	if err != nil {
		log.Printf("debug: %s\n", err.Error())
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
		return
	}
	defer r.Body.Close()
	var wd ArinRdapData
	err = json.NewDecoder(r.Body).Decode(&wd)
	if err != nil {
		log.Printf("debug: %s\n", err.Error())
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
		return
	}
	//response
	err = json.NewEncoder(w).Encode(&wd)
	if err != nil {
		log.Printf("debug: %s\n", err.Error())
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
		return
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
