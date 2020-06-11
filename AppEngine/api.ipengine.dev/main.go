package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"net"
	"net/http"
	"os"
	"strconv"
	"strings"
	"time"
)

type Entities struct {
	Handle     string        `json:"handle"`
	VcardArray []interface{} `json:"vcardArray"`
	Events     []struct {
		EventAction string `json:"eventAction"`
		EventDate   string `json:"eventDate"`
	} `json:"events"`
	Entities        []Entities `json:"entities"`
	ObjectClassName string     `json:"objectClassName"`
}

type ArinRdapData struct {
	Handle       string `json:"handle"`
	StartAddress string `json:"startAddress"`
	EndAddress   string `json:"endAddress"`
	IpVersion    string `json:"ipVersion"`
	Name         string `json:"name"`
	Type         string `json:"type"`
	ParentHandle string `json:"parentHandle"`
	Events       []struct {
		EventAction string `json:"eventAction"`
		EventDate   string `json:"eventDate"`
	} `json:"events"`
	Entities   []Entities `json:"entities"`
	Cidr0Cidrs []struct {
		V4Prefix string `json:"v4prefix"`
		Length   int    `json:"length"`
	} `json:"cidr0_cidrs"`
}

type NetworkInfo struct {
	Ip       string `json:"ip"`
	Hostname string `json:"hostname"`
	Reverse  string `json:"reverse"`
}

//ArinInfo data
type ArinInfo struct {
	Name         string `json:"name"`
	Handle       string `json:"handle"`
	Parent       string `json:"parent"`
	Type         string `json:"type"`
	Range        string `json:"range"`
	Cidr         string `json:"cidr"`
	Registration string `json:"registration"`
	Updated      string `json:"updated"`
}

//OrgnizationInfo data
type OrgnizationInfo struct {
	Name         string `json:"name"`
	Handle       string `json:"handle"`
	Street       string `json:"street"`
	City         string `json:"city"`
	Province     string `json:"province"`
	Postal       string `json:"postal"`
	Country      string `json:"country"`
	Registration string `json:"registration"`
	Updated      string `json:"updated"`
}

//ContactInfo data
type ContactInfo struct {
	Name         string `json:"name"`
	Handle       string `json:"handle"`
	Company      string `json:"company"`
	Street       string `json:"street"`
	City         string `json:"city"`
	Province     string `json:"province"`
	Postal       string `json:"postal"`
	Country      string `json:"country"`
	Registration string `json:"registration"`
	Updated      string `json:"updated"`
	Phone        string `json:"phone"`
	Email        string `json:"email"`
}

//Response data
type Response struct {
	Arin        ArinInfo        `json:"arin"`
	Orgnization OrgnizationInfo `json:"orgnization"`
	Contact     ContactInfo     `json:"contact"`
	Network     NetworkInfo     `json:"network"`
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
	log.Println("Api begins")
	err = http.ListenAndServe(":8080", r)
	log.Fatal(err.Error())
}

func initLogger() error {
	//output (fileMode: -rw-r--r--)
	lf, err := os.OpenFile("logs.log", os.O_CREATE|os.O_APPEND|os.O_WRONLY, 0644)
	if err != nil {
		log.Printf("debug: %s\n", err.Error())
		return errors.New("Failed to initialise the logger!")
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

func getVCardForContact(entities []Entities, contact *ContactInfo) {
	for _, entity := range entities {
		contact.Handle = entity.Handle
		for _, event := range entity.Events {
			if event.EventAction == "registration" {
				contact.Registration = event.EventDate
			}
			if event.EventAction == "last changed" {
				contact.Updated = event.EventDate
			}
		}
		for _, d := range entity.VcardArray {
			rt, ok := d.([]interface{})
			if ok {
				for _, da := range rt {
					rt, ok = da.([]interface{})
					if ok {
						for i, data := range rt {
							if data == "fn" {
								contact.Name, _ = rt[i+3].(string)
							}
							if data == "adr" {
								comp, ok := rt[i+1].(map[string]interface{})
								if ok {
									// fmt.Println(comp["label"].(string))
									arr := strings.Split(comp["label"].(string), "\n")
									contact.Street = arr[0]
									contact.City = arr[1]
									contact.Province = arr[2]
									contact.Postal = arr[3]
									contact.Country = arr[4]
								}
							}
							if data == "email" {
								contact.Email, _ = rt[i+3].(string)
							}
							if data == "tel" {
								contact.Phone, _ = rt[i+3].(string)
							}
						}
					}
				}
			}
		}
	}
}

func getVCard(wd ArinRdapData, org *OrgnizationInfo, contact *ContactInfo) {
	for _, entity := range wd.Entities {
		getVCardForContact(entity.Entities, contact)
		org.Handle = entity.Handle
		for _, event := range entity.Events {
			if event.EventAction == "registration" {
				org.Registration = event.EventDate
			}
			if event.EventAction == "last changed" {
				org.Updated = event.EventDate
			}
		}
		for _, d := range entity.VcardArray {
			rt, ok := d.([]interface{})
			if ok {
				for _, da := range rt {
					rt, ok = da.([]interface{})
					if ok {
						for i, data := range rt {
							if data == "fn" {
								org.Name, _ = rt[i+3].(string)
							}
							if data == "adr" {
								comp, ok := rt[i+1].(map[string]interface{})
								if ok {
									// fmt.Println(comp["label"].(string))
									arr := strings.Split(comp["label"].(string), "\n")
									org.Street = arr[0]
									org.City = arr[1]
									org.Province = arr[2]
									org.Postal = arr[3]
									org.Country = arr[4]
								}
							}
						}
					}
				}
			}
		}

	}
}

func returnWhoisData(ip string, w http.ResponseWriter) {
	//whois data
	c := http.Client{
		Timeout: time.Duration(time.Second * 30),
	}
	url := fmt.Sprintf("https://rdap.arin.net/registry/ip/%s", ip)
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
	if wd.Handle == "" || wd.EndAddress == "" || wd.StartAddress == "" {
		http.Error(w, http.StatusText(http.StatusNotFound), http.StatusNotFound)
		return
	}
	updated := ""
	registration := ""
	for _, event := range wd.Events {
		if event.EventAction == "registration" {
			registration = event.EventDate
		}
		if event.EventAction == "last changed" {
			updated = event.EventDate
		}
	}
	arin := ArinInfo{
		Name:         wd.Name,
		Handle:       wd.Handle,
		Parent:       wd.ParentHandle,
		Type:         wd.Type,
		Range:        wd.StartAddress + "-" + wd.EndAddress,
		Cidr:         wd.Cidr0Cidrs[0].V4Prefix + "/" + strconv.Itoa(wd.Cidr0Cidrs[0].Length),
		Registration: registration,
		Updated:      updated,
	}
	org := OrgnizationInfo{}
	contact := ContactInfo{}

	host, _ := net.LookupAddr(ip)
	revIP, _ := net.LookupIP(host[0])
	revIPStr := revIP[0].String()
	fmt.Println(revIPStr)
	network := NetworkInfo{
		Hostname: host[0],
		Ip:       ip,
		Reverse:  revIPStr,
	}

	getVCard(wd, &org, &contact)

	resp := Response{
		Arin:        arin,
		Orgnization: org,
		Contact:     contact,
		Network:     network,
	}

	w.Header().Add("Content-Type", "application/json")
	w.Header().Add("Content-Security-Policy", "script-src 'self'; object-src 'self'")
	w.Header().Add("Referrer-Policy", "strict-origin")
	w.Header().Add("Strict-Transport-Security", "max-age=63072000; includeSubDomains; preload")
	w.Header().Add("Feature-Policy", "vibrate 'self'")
	w.Header().Add("X-Frame-Options", "SAMEORIGIN")
	w.Header().Add("X-Content-Type-Options", "nosniff")
	//response
	err = json.NewEncoder(w).Encode(&resp)
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
		return "", errors.New("Failed to get ip parameter!")
	}
}

func getReverseIp(r *http.Request) string {
	ff := r.Header.Get("CF-Connecting-IP")
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
