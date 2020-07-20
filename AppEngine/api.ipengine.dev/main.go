package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"log"
	"net"
	"net/http"
	"os"
	"strconv"
	"strings"
	"time"
)

const IPSET_FILE = "output.json"

var blockips BlockIP

// var blockips = NewBlockIP(IPSET_INTVAL)
type AnaylsisResult map[string]bool

type BlockIP map[string][]string

type Entities struct {
	Handle     string        `json:"handle"`
	VcardArray []interface{} `json:"vcardArray"`
	Events     []struct {
		EventAction string `json:"eventAction"`
		EventDate   string `json:"eventDate"`
	} `json:"events"`
	Entities        []Entities `json:"entities"`
	Roles           []string   `json:"roles"`
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
	Status     []string   `json:"status"`
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
	Name         string   `json:"name"`
	Handle       string   `json:"handle"`
	Parent       string   `json:"parent"`
	Type         string   `json:"type"`
	Range        string   `json:"range"`
	Cidr         string   `json:"cidr"`
	Status       []string `json:"status"`
	Registration string   `json:"registration"`
	Updated      string   `json:"updated"`
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

type AbuseInfo struct {
	Name         string `json:"name"`
	Handle       string `json:"handle"`
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
	Network     NetworkInfo     `json:"network"`
	Arin        ArinInfo        `json:"arin"`
	Orgnization OrgnizationInfo `json:"orgnization"`
	Contact     ContactInfo     `json:"contact"`
	Abuse       AbuseInfo       `json:"abuse"`
	Anaylsis    AnaylsisResult  `json:"anaylsis"`
}

func init() {
	log.SetFlags(log.Lshortfile)
	// init blockip datasource
	// open blockip file
	f, e := os.OpenFile(IPSET_FILE, os.O_RDONLY, 0666)
	if e != nil {
		log.Println(e)
		return
	}
	blockips = NewBlockIP(f)
}

func main() {

	//router
	r := http.NewServeMux()
	//routes
	r.HandleFunc("/", reverseIpHandler)
	r.HandleFunc("/ip/", ipHandler)
	//http server
	http.ListenAndServe(":8080", r)
}

func NewBlockIP(f io.Reader) (bip BlockIP) {
	bip = make(BlockIP)
	bip.load(f)
	return
}

func (bip *BlockIP) load(f io.Reader) {
	dc := json.NewDecoder(f)
	e := dc.Decode(bip)
	if e != nil {
		log.Println(e)
		return
	}
}

func (bip BlockIP) Anaylsis(ip string) (rs AnaylsisResult) {
	rs = make(AnaylsisResult)
	for k, v := range bip {
		// detect if ip in v
		rs[k] = false
		for _, va := range v {
			if va == ip {
				rs[k] = true
				break
			}
			// if v contains "/" in the last 3 pst
			if strings.Contains(va, "/") {
				if ipinet(ip, va) {
					rs[k] = true
					break
				}
				va = va[:len(va)-3]
			}

			// compare the ip value
			// when va greate than ip then break
			ipi, e := IPString2Long(ip)
			if e != nil {
				log.Println(ip, e)
			}
			ipv, e := IPString2Long(va)
			if e != nil {
				log.Println(va, e)
			}
			// log.Println(ipi, ipv, va)
			if ipv > ipi {
				break
			}
		}
	}
	return
}

func ipinet(ip string, cidr string) (r bool) {
	ipx, subnet, _ := net.ParseCIDR(cidr)
	ipa := net.ParseIP(ip)
	// if netip eq ip then check ip existing
	if subnet.IP.Equal(ipx) {
		r = subnet.Contains(ipa)
		return
	}
	r = ipa.Equal(ipx)
	return
}

func IPString2Long(ip string) (uint, error) {
	b := net.ParseIP(ip).To4()
	if b == nil {
		return 0, errors.New("invalid ipv4 format")
	}

	return uint(b[3]) | uint(b[2])<<8 | uint(b[1])<<16 | uint(b[0])<<24, nil
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
		log.Println(err)
		http.Error(w, http.StatusText(http.StatusNotFound), http.StatusNotFound)
		return
	}
	log.Println(ip)
	returnWhoisData(ip, w)
}

func getVCardForContact(entities []Entities, contact *ContactInfo) {

	for _, entity := range entities {
		// if !contains(entity.Roles, "technical") {
		// 	break
		// }
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

func contains(s []string, e string) bool {
	for _, a := range s {
		if a == e {
			return true
		}
	}
	return false
}

func getVCardForAbuse(entities []Entities, abuse *AbuseInfo) {
	for _, entity := range entities {
		if contains(entity.Roles, "technical") {
			break
		}
		if !contains(entity.Roles, "abuse") {
			break
		}
		abuse.Handle = entity.Handle
		for _, event := range entity.Events {
			if event.EventAction == "registration" {
				abuse.Registration = event.EventDate
			}
			if event.EventAction == "last changed" {
				abuse.Updated = event.EventDate
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
								abuse.Name, _ = rt[i+3].(string)
							}
							if data == "adr" {
								comp, ok := rt[i+1].(map[string]interface{})
								if ok {
									// fmt.Println(comp["label"].(string))
									arr := strings.Split(comp["label"].(string), "\n")
									abuse.Street = arr[0]
									abuse.City = arr[1]
									abuse.Province = arr[2]
									abuse.Postal = arr[3]
									abuse.Country = arr[4]
								}
							}
							if data == "email" {
								abuse.Email, _ = rt[i+3].(string)
							}
							if data == "tel" {
								abuse.Phone, _ = rt[i+3].(string)
							}
						}
					}
				}
			}
		}
	}
}

func getVCard(wd ArinRdapData, org *OrgnizationInfo, contact *ContactInfo, abuse *AbuseInfo) {
	for _, entity := range wd.Entities {
		getVCardForContact(entity.Entities, contact)
		getVCardForAbuse(entity.Entities, abuse)
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

	// create request
	url := fmt.Sprintf("https://rdap.arin.net/registry/ip/%s", ip)
	req, e := http.NewRequest("GET", url, nil)
	if e != nil {
		log.Println(e)
		return
	}
	req.Header.Add("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9")
	req.Header.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36")
	req.Header.Add("Sec-Fetch-Dest", "document")
	req.Header.Add("Cache-Control", "no-cache")
	req.Header.Add("Accept-Encoding", "gzip, deflate, br")
	req.Header.Add("Connection", "keep-alive")
	req.Header.Add("Host", "rdap.arin.net")
	req.Header.Add("Sec-Fetch-Mode", "navigate")
	req.Header.Add("Sec-Fetch-Site", "cross-site")
	req.Header.Add("Sec-Fetch-User", "?1")
	req.Header.Add("Upgrade-Insecure-Requests", "1")

	r, err := c.Do(req)
	if err != nil {
		log.Println(err)
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
		return
	}
	defer r.Body.Close()
	var wd ArinRdapData
	err = json.NewDecoder(r.Body).Decode(&wd)
	if err != nil {
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
		Status:       wd.Status,
		Registration: registration,
		Updated:      updated,
	}
	org := OrgnizationInfo{}
	contact := ContactInfo{}
	abuse := AbuseInfo{}
	host := []string{""}
	revIPStr := ""

	host, err = net.LookupAddr(ip)
	if err == nil {
		revIP, err := net.LookupIP(host[0])
		if err == nil {
			revIPStr = revIP[0].String()
			fmt.Println(revIPStr)
		}
	} else {
		host = []string{""}
	}
	network := NetworkInfo{
		Hostname: host[0],
		Ip:       ip,
		Reverse:  revIPStr,
	}

	getVCard(wd, &org, &contact, &abuse)

	// get block info
	an := blockips.Anaylsis(ip)

	resp := Response{
		Arin:        arin,
		Orgnization: org,
		Contact:     contact,
		Network:     network,
		Abuse:       abuse,
		Anaylsis:    an,
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
