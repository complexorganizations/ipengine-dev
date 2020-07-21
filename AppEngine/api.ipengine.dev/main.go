package main

import (
	"bufio"
	"encoding/json"
	"errors"
	"io"
	"log"
	"net"
	"net/http"
	"os"
	"strings"

	whois "github.com/likexian/whois-go"
)

const IPSET_FILE = "sample.ipset"

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
	Orgnization OrgnizationInfo `json:"orgnization,omitempty"`
	Contact     ContactInfo     `json:"contact,omitempty"`
	Abuse       ContactInfo     `json:"abuse,omitempty"`
	Anaylsis    AnaylsisResult  `json:"anaylsis,omitempty"`
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
	// r.HandleFunc("/", reverseIpHandler)
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
	raw, e := whois.Whois(ip)
	if e != nil {
		log.Println(e)
		return
	}
	// fmt.Println(raw)
	// parse raw
	rd := bufio.NewReader(strings.NewReader(string(raw)))
	// process document line by line
	// onProcess := false
	p := ""
	for {
		l, e := rd.ReadString('\n')
		if e != nil {
			break
		}

		if strings.HasPrefix(l, "#") || len(strings.Trim(l, " ")) == 0 {
			continue
		}

		switch {
		case strings.HasPrefix(l, "NetRange"):
			p = "arin"
		case strings.HasPrefix(l, "OrgName"):
			p = "org"
		case strings.HasPrefix(l, "OrgTechHandle"):
			p = "contact"
		case strings.HasPrefix(l, "OrgAbuse"):
			p = "abuse"
		}
		log.Println(p, l)
		switch p {
		case "arin":
			if &rsp.Arin == nil {
				rsp.Arin = ArinInfo{}
			}
			switch {
			case strings.HasPrefix(l, "NetRange:"):
				rsp.Arin.Range = getContent(l)
			case strings.HasPrefix(l, "CIDR:"):
				rsp.Arin.Cidr = getContent(l)
			case strings.HasPrefix(l, "NetName:"):
				rsp.Arin.Name = getContent(l)
			case strings.HasPrefix(l, "NetHandle:"):
				rsp.Arin.Handle = getContent(l)
			case strings.HasPrefix(l, "Parent:"):
				rsp.Arin.Parent = getContent(l)
			case strings.HasPrefix(l, "NetType:"):
				rsp.Arin.Type = getContent(l)
			case strings.HasPrefix(l, "RegDate:"):
				rsp.Arin.Registration = getContent(l)
			case strings.HasPrefix(l, "Updated:"):
				rsp.Arin.Updated = getContent(l)
				// case strings.HasPrefix(l, "# end"):
				// 	onProcess = false
				// 	return
			}
		case "org":
			if &rsp.Orgnization == nil {
				rsp.Orgnization = OrgnizationInfo{}
			}
			switch {
			case strings.HasPrefix(l, "OrgName"):
				rsp.Orgnization.Name = getContent(l)
			// case strings.HasPrefix(l, "OrgId"):
			// 	rsp.Orgnization.
			case strings.HasPrefix(l, "Address"):
				rsp.Orgnization.Street = rsp.Orgnization.Street + getContent(l)
			case strings.HasPrefix(l, "City"):
				rsp.Orgnization.City = getContent(l)
			case strings.HasPrefix(l, "StateProv"):
				rsp.Orgnization.Province = getContent(l)
			case strings.HasPrefix(l, "PostalCode"):
				rsp.Orgnization.Postal = getContent(l)
			case strings.HasPrefix(l, "Country"):
				rsp.Orgnization.Country = getContent(l)
			case strings.HasPrefix(l, "RegDate"):
				rsp.Orgnization.Registration = getContent(l)
			case strings.HasPrefix(l, "Updated"):
				rsp.Orgnization.Updated = getContent(l)
				// case strings.HasPrefix(l, "# end"):
				// 	onProcess = false
				// 	return
			}
		case "abuse":
			if &rsp.Abuse == nil {
				rsp.Abuse = ContactInfo{}
			}
			switch {
			case strings.HasPrefix(l, "OrgAbuseHandle"):
				rsp.Abuse.Handle = getContent(l)
			case strings.HasPrefix(l, "OrgAbuseName"):
				rsp.Abuse.Name = getContent(l)
			case strings.HasPrefix(l, "OrgAbusePhone"):
				rsp.Abuse.Phone = getContent(l)
			case strings.HasPrefix(l, "OrgAbuseEmail"):
				rsp.Abuse.Email = getContent(l)
				// case strings.HasPrefix(l, "# end"):
				// 	onProcess = false
				// 	return
			}
		case "contact":
			if &rsp.Contact == nil {
				rsp.Contact = ContactInfo{}
			}
			switch {
			case strings.HasPrefix(l, "OrgTechHandle"):
				rsp.Contact.Handle = getContent(l)
			case strings.HasPrefix(l, "OrgTechName"):
				rsp.Contact.Name = getContent(l)
			case strings.HasPrefix(l, "OrgTechEmail"):
				rsp.Contact.Email = getContent(l)
				// case strings.HasPrefix(l, "# end"):
				// 	onProcess = false
				// 	return

			}
		}

	}

}

func getContent(ct string) (r string) {
	idx := strings.Index(ct, ":")
	r = strings.Trim(ct[idx+1:], " ")
	r = strings.Trim(r, "\n")
	return
}

func reverseIpHandler(w http.ResponseWriter, r *http.Request) {
	//reverse ip
	rip := getReverseIp(r)
	rsp := NewResponse(rip)
	e := json.NewEncoder(w).Encode(rsp)
	if e != nil {
		log.Println(e)
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

func ipHandler(w http.ResponseWriter, r *http.Request) {
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
