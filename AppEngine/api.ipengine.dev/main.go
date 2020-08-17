package main

import (
	"encoding/json"
	"errors"
	"io"
	"log"
	"net"
	"net/http"
	"os"
	"strings"

	"github.com/openrdap/rdap"
)

const IPSET_FILE = "output.json"

var blockips BlockIP

// var blockips = NewBlockIP(IPSET_INTVAL)
type AnaylsisResult map[string]bool

type BlockIP map[string][]string

type NetworkInfo struct {
	Ip       string `json:"ip"`
	Hostname string `json:"hostname"`
	Reverse  string `json:"reverse"`
}

//ArinInfo data
type ArinInfo struct {
	Name         string   `json:"name,omitempty"`
	Handle       string   `json:"handle,omitempty"`
	Parent       string   `json:"parent,omitempty"`
	Type         string   `json:"type,omitempty"`
	Range        string   `json:"range,omitempty"`
	Cidr         string   `json:"cidr,omitempty"`
	Status       []string `json:"status,omitempty"`
	Registration string   `json:"registration,omitempty"`
	Updated      string   `json:"updated,omitempty"`
}

//OrgnizationInfo data
type OrgnizationInfo struct {
	Name         string `json:"name,omitempty"`
	Handle       string `json:"handle,omitempty"`
	Street       string `json:"street,omitempty"`
	City         string `json:"city,omitempty"`
	Province     string `json:"province,omitempty"`
	Postal       string `json:"postal,omitempty"`
	Country      string `json:"country,omitempty"`
	Registration string `json:"registration,omitempty"`
	Updated      string `json:"updated,omitempty"`
}

//ContactInfo data
type ContactInfo struct {
	Name         string `json:"name,omitempty"`
	Handle       string `json:"handle,omitempty"`
	Company      string `json:"company,omitempty"`
	Street       string `json:"street,omitempty"`
	City         string `json:"city,omitempty"`
	Province     string `json:"province,omitempty"`
	Postal       string `json:"postal,omitempty"`
	Country      string `json:"country,omitempty"`
	Registration string `json:"registration,omitempty"`
	Updated      string `json:"updated,omitempty"`
	Phone        string `json:"phone,omitempty"`
	Email        string `json:"email,omitempty"`
}

//Response data
type Response struct {
	Network     NetworkInfo     `json:"network,omitempty"`
	Arin        ArinInfo        `json:"arin,omitempty"`
	Orgnization OrgnizationInfo `json:"organization,omitempty"`
	Contact     ContactInfo     `json:"contact,omitempty"`
	Abuse       ContactInfo     `json:"abuse,omitempty"`
	Anaylsis    AnaylsisResult  `json:"analysis,omitempty"`
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

func NewResponse(ip string) (rsp *Response) {
	rsp = new(Response)
	// process
	rsp.parseNetWork(ip)
	rsp.Parse(ip)
	return
}

func (rsp *Response) parseNetWork(ip string) {
	// set default value
	rsp.Network = NetworkInfo{}
	rsp.Network.Ip = ip

	host, err := net.LookupAddr(ip)
	if err != nil || len(host) == 0 {
		log.Println(err, ip)
		return
	}

	revIP, err := net.LookupIP(host[0])
	if err != nil || len(revIP) == 0 {
		return
	}
	// update network value
	rsp.Network.Hostname = host[0]
	rsp.Network.Reverse = revIP[0].String()
}

func (rsp *Response) Parse(ip string) {
	// read whois information
	c := &rdap.Client{}
	rs, e := c.QueryIP(ip)
	if e != nil {
		log.Println(e)
		return
	}
	// arinfo
	rsp.Arin.Name = rs.Name
	rsp.Arin.Cidr = rs.Handle
	rsp.Arin.Handle = rs.Handle
	rsp.Arin.Parent = rs.ParentHandle
	rsp.Arin.Range = rs.StartAddress + "-" + rs.EndAddress
	rsp.Arin.Type = rs.Type
	// update registration and updated
	for _, v := range rs.Events {
		switch v.Action {
		case "registration":
			rsp.Arin.Registration = v.Date
		case "last changed":
			rsp.Arin.Updated = v.Date
		}
	}

	for _, ett := range rs.Entities {
		if ett.VCard == nil {
			continue
		}
		switch {
		// orgnization infomation
		case isExists(ett.Roles, "registrant"):
			rsp.Orgnization.Country = ett.VCard.Country()
			rsp.Orgnization.City = ett.VCard.ExtendedAddress()
			rsp.Orgnization.Handle = ett.Handle
			rsp.Orgnization.Name = ett.VCard.Name()
			rsp.Orgnization.Postal = ett.VCard.PostalCode()
			rsp.Orgnization.Province = ett.VCard.Region()
			for _, v := range ett.Events {
				switch v.Action {
				case "registration":
					rsp.Orgnization.Registration = v.Date
				case "last changed":
					rsp.Orgnization.Updated = v.Date
				}
			}
			rsp.Orgnization.Street = ett.VCard.StreetAddress()
		// abuse information
		case isExists(ett.Roles, "abuse"):
			rsp.Abuse.Country = ett.VCard.Country()
			rsp.Abuse.City = ett.VCard.ExtendedAddress()
			rsp.Abuse.Email = ett.VCard.Email()
			rsp.Abuse.Handle = ett.Handle
			rsp.Abuse.Name = ett.VCard.Name()
			rsp.Abuse.Phone = ett.VCard.Tel()
			rsp.Abuse.Postal = ett.VCard.PostalCode()
			rsp.Abuse.Province = ett.VCard.Region()
			for _, v := range ett.Events {
				switch v.Action {
				case "registration":
					rsp.Abuse.Registration = v.Date
				case "last changed":
					rsp.Abuse.Updated = v.Date
				}
			}
			rsp.Abuse.Street = ett.VCard.StreetAddress()
			fallthrough
		// contact
		case isExists(ett.Roles, "administrative"):
			rsp.Contact.City = ett.VCard.ExtendedAddress()
			rsp.Contact.Country = ett.VCard.Country()
			rsp.Contact.Email = ett.VCard.Email()
			rsp.Contact.Handle = ett.Handle
			rsp.Contact.Name = ett.VCard.Name()
			rsp.Contact.Phone = ett.VCard.Tel()
			rsp.Contact.Postal = ett.VCard.PostalCode()
			rsp.Contact.Province = ett.VCard.Region()
			for _, v := range ett.Events {
				switch v.Action {
				case "registration":
					rsp.Contact.Registration = v.Date
				case "last changed":
					rsp.Contact.Updated = v.Date
				}
			}
			rsp.Contact.Street = ett.VCard.StreetAddress()
		}
	}
}

func isExists(src []string, item string) (r bool) {
	for _, v := range src {
		if v == item {
			r = true
			break
		}
	}
	return
}

func getContent(ct string) (r string) {
	idx := strings.Index(ct, ":")
	r = strings.Trim(ct[idx+1:], " ")
	r = strings.Trim(r, "\n")
	return
}

func reverseIpHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	//reverse ip
	rip := getReverseIp(r)
	rsp := NewResponse(rip)
	e := json.NewEncoder(w).Encode(rsp)
	if e != nil {
		log.Println(e)
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

func ipHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	//ip
	ip, err := getIpParam(r)
	if err != nil {
		log.Println(err)
		http.Error(w, http.StatusText(http.StatusNotFound), http.StatusNotFound)
		return
	}
	rsp := NewResponse(ip)
	// anaylsis
	rsp.Anaylsis = blockips.Anaylsis(ip)

	e := json.NewEncoder(w).Encode(rsp)
	if e != nil {
		log.Println(e)
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
