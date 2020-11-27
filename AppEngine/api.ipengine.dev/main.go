package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"github.com/openrdap/rdap"
	"github.com/oschwald/geoip2-golang"
	"io"
	"log"
	"net"
	"net/http"
	"os"
	"strings"
)

type Response struct {
	Network      NetworkInfo      `json:"network,omitempty"`
	Location     Location         `json:"location,omitempty"`
	Arin         ArinInfo         `json:"arin,omitempty"`
	Organization OrganizationInfo `json:"organization,omitempty"`
	Contact      ContactInfo      `json:"contact,omitempty"`
	Abuse        ContactInfo      `json:"abuse,omitempty"`
	Analysis     AnalysisResult   `json:"analysis,omitempty"`
}

type Server struct {
	router *http.ServeMux
}

type NetworkInfo struct {
	Ip       string `json:"ip"`
	Hostname string `json:"hostname"`
	Reverse  string `json:"reverse"`
	Asn      string `json:"asn,omitempty"`
}

type Location struct {
	City    string `json:"city,omitempty"`
	Country string `json:"country,omitempty"`
}

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

type OrganizationInfo struct {
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

type BlockIP map[string][]string

type AnalysisResult map[string]bool

const (
	Port      = ":8080"
	IPSetFile = "blockips.json"
)

var (
	asnDB     *geoip2.Reader
	cityDB    *geoip2.Reader
	countryDB *geoip2.Reader
	blockIPs  BlockIP
)

func main() {
	asn, err := geoip2.Open("GeoLite2-ASN.mmdb")
	if err != nil {
		log.Println(err)
	}
	defer func() { _ = asn.Close() }()
	city, err := geoip2.Open("GeoLite2-City.mmdb")
	if err != nil {
		log.Println(err)
	}
	defer func() { _ = city.Close() }()
	country, err := geoip2.Open("GeoLite2-Country.mmdb")
	if err != nil {
		log.Println(err)
	}
	defer func() { _ = country.Close() }()
	asnDB = asn
	cityDB = city
	countryDB = country
	blockIPs = LoadBlockIPs(IPSetFile)
	server := NewServer()
	_ = server.Run(Port)
}

func NewServer() *Server {
	r := http.NewServeMux()
	return &Server{
		router: r,
	}
}

func (s Server) Run(port string) error {
	s.router.HandleFunc("/", s.ReverseIPHandler())
	s.router.HandleFunc("/ip/", s.IPHandler())
	return http.ListenAndServe(port, s.router)
}

func (s *Server) Write(writer http.ResponseWriter, data interface{}) error {
	return json.NewEncoder(writer).Encode(data)
}

func (s *Server) WriteError(writer http.ResponseWriter, status int) {
	http.Error(writer, http.StatusText(status), status)
}

func (s *Server) ReverseIPHandler() http.HandlerFunc {
	return func(writer http.ResponseWriter, request *http.Request) {
		writer.Header().Set("Content-Type", "application/json")
		ip := GetReverseIP(request)
		if ip == nil {
			s.WriteError(writer, http.StatusNotFound)
			return
		}
		err := s.Write(writer, NewResponse(ip))
		if err != nil {
			log.Println(err)
		}
	}
}

func (s *Server) IPHandler() http.HandlerFunc {
	return func(writer http.ResponseWriter, request *http.Request) {
		writer.Header().Set("Content-Type", "application/json")
		ip, err := GetIPFromParameter(request)
		if err != nil || ip == nil {
			log.Println(err)
			s.WriteError(writer, http.StatusNotFound)
			return
		}
		rsp := NewResponse(ip)
		rsp.Analysis = blockIPs.Analyse(ip.String())
		err = s.Write(writer, rsp)
		if err != nil {
			log.Println(err)
		}
	}
}

func GetReverseIP(r *http.Request) net.IP {
	ff := r.Header.Get("CF-Connecting-IP")
	if ff == "" {
		return GetIP(r.RemoteAddr)
	}
	return net.ParseIP(ff)
}

func GetIP(remoteAddress string) net.IP {
	return net.ParseIP(remoteAddress[0:strings.Index(remoteAddress, ":")])
}

func GetIPFromParameter(r *http.Request) (net.IP, error) {
	ip := r.URL.Path[4:]
	if strings.Index(ip, "/") != -1 {
		return nil, errors.New("failed to get ip parameter")
	}
	return net.ParseIP(ip), nil
}

func NewResponse(ip net.IP) *Response {
	response := &Response{
		Network:  ParseNetWork(ip),
		Location: ParseLocation(ip),
	}
	c := &rdap.Client{}
	network, err := c.QueryIP(ip.String())
	if err != nil {
		log.Println(err)
		return response
	}
	response.Arin = ParseArin(network)
	org, cont, abuse := ParseEntities(network)
	response.Organization = org
	response.Contact = cont
	response.Abuse = abuse
	return response
}

func ParseNetWork(ip net.IP) NetworkInfo {
	network := NetworkInfo{}
	network.Ip = ip.String()
	host, err := net.LookupAddr(ip.String())
	if err != nil || len(host) == 0 {
		log.Println(err, ip)
		return network
	}
	revIP, err := net.LookupIP(host[0])
	if err != nil || len(revIP) == 0 {
		return network
	}
	network.Hostname = host[0]
	network.Reverse = revIP[0].String()
	asn, err := asnDB.ASN(ip)
	if err != nil || len(host) == 0 {
		log.Println(err, ip)
		return network
	}
	network.Asn = fmt.Sprint(asn.AutonomousSystemNumber)
	return network
}

func ParseLocation(ip net.IP) Location {
	loc := Location{}
	city, err := cityDB.City(ip)
	if err == nil {
		loc.City = city.City.Names["en"]
	}
	country, err := countryDB.Country(ip)
	if err == nil {
		loc.Country = country.Country.Names["en"]
	}
	return loc
}

func ParseArin(network *rdap.IPNetwork) ArinInfo {
	arin := ArinInfo{}
	arin.Name = network.Name
	arin.Cidr = network.Handle
	arin.Handle = network.Handle
	arin.Parent = network.ParentHandle
	arin.Range = network.StartAddress + "-" + network.EndAddress
	arin.Type = network.Type
	arin.Status = network.Status
	for _, v := range network.Events {
		switch v.Action {
		case "registration":
			arin.Registration = v.Date
		case "last changed":
			arin.Updated = v.Date
		}
	}
	return arin
}

func ParseEntities(network *rdap.IPNetwork) (OrganizationInfo, ContactInfo, ContactInfo) {
	org := OrganizationInfo{}
	contact := ContactInfo{}
	abuse := ContactInfo{}
	for _, ent := range network.Entities {
		if ent.VCard == nil {
			continue
		}
		if ent.Entities != nil {
			for _, entEnt := range ent.Entities {
				switch {
				// abuse information
				case HasRole(entEnt.Roles, "abuse"):
					abuse.Country = entEnt.VCard.Country()
					abuse.City = entEnt.VCard.ExtendedAddress()
					abuse.Email = entEnt.VCard.Email()
					abuse.Handle = entEnt.Handle
					abuse.Name = entEnt.VCard.Name()
					abuse.Phone = entEnt.VCard.Tel()
					abuse.Postal = entEnt.VCard.PostalCode()
					abuse.Province = entEnt.VCard.Region()
					for _, v := range ent.Events {
						switch v.Action {
						case "registration":
							abuse.Registration = v.Date
						case "last changed":
							abuse.Updated = v.Date
						}
					}
					abuse.Street = ent.VCard.StreetAddress()
					fallthrough
				case HasRole(entEnt.Roles, "administrative"):
					contact.City = entEnt.VCard.ExtendedAddress()
					contact.Country = entEnt.VCard.Country()
					contact.Email = entEnt.VCard.Email()
					contact.Handle = entEnt.Handle
					contact.Name = entEnt.VCard.Name()
					contact.Phone = entEnt.VCard.Tel()
					contact.Postal = entEnt.VCard.PostalCode()
					contact.Province = entEnt.VCard.Region()
					for _, v := range ent.Events {
						switch v.Action {
						case "registration":
							contact.Registration = v.Date
						case "last changed":
							contact.Updated = v.Date
						}
					}
					contact.Street = ent.VCard.StreetAddress()
				}
			}
		}
		switch {
		case HasRole(ent.Roles, "registrant"):
			org.Country = ent.VCard.Country()
			org.City = ent.VCard.ExtendedAddress()
			org.Handle = ent.Handle
			org.Name = ent.VCard.Name()
			org.Postal = ent.VCard.PostalCode()
			org.Province = ent.VCard.Region()
			for _, v := range ent.Events {
				switch v.Action {
				case "registration":
					org.Registration = v.Date
				case "last changed":
					org.Updated = v.Date
				}
			}
			org.Street = ent.VCard.StreetAddress()
		case HasRole(ent.Roles, "abuse"):
			abuse.Country = ent.VCard.Country()
			abuse.City = ent.VCard.ExtendedAddress()
			abuse.Email = ent.VCard.Email()
			abuse.Handle = ent.Handle
			abuse.Name = ent.VCard.Name()
			abuse.Phone = ent.VCard.Tel()
			abuse.Postal = ent.VCard.PostalCode()
			abuse.Province = ent.VCard.Region()
			for _, v := range ent.Events {
				switch v.Action {
				case "registration":
					abuse.Registration = v.Date
				case "last changed":
					abuse.Updated = v.Date
				}
			}
			abuse.Street = ent.VCard.StreetAddress()
			fallthrough
		case HasRole(ent.Roles, "administrative"):
			contact.City = ent.VCard.ExtendedAddress()
			contact.Country = ent.VCard.Country()
			contact.Email = ent.VCard.Email()
			contact.Handle = ent.Handle
			contact.Name = ent.VCard.Name()
			contact.Phone = ent.VCard.Tel()
			contact.Postal = ent.VCard.PostalCode()
			contact.Province = ent.VCard.Region()
			for _, v := range ent.Events {
				switch v.Action {
				case "registration":
					contact.Registration = v.Date
				case "last changed":
					contact.Updated = v.Date
				}
			}
			contact.Street = ent.VCard.StreetAddress()
		}
	}
	return org, contact, abuse
}

func HasRole(src []string, item string) bool {
	for _, v := range src {
		if v == item {
			return true
		}
	}
	return false
}

func LoadBlockIPs(fileName string) BlockIP {
	blockIps := BlockIP{}
	file, err := os.Open(fileName)
	if err != nil {
		log.Println(err)
		return blockIps
	}
	blockIps.Load(file)
	return blockIps
}

func (bip *BlockIP) Load(file io.Reader) {
	if err := json.NewDecoder(file).Decode(bip); err != nil {
		log.Println(err)
		return
	}
}

func (bip BlockIP) Analyse(ip string) AnalysisResult {
	rs := AnalysisResult{}
	for k, v := range bip {
		rs[k] = false
		for _, va := range v {
			if va == ip {
				rs[k] = true
				break
			}
			if strings.Contains(va, "/") {
				if IPInet(ip, va) {
					rs[k] = true
					break
				}
				va = va[:len(va)-3]
			}
			ipi, err := IPString2Long(ip)
			if err != nil {
				log.Println(ip, err)
			}
			ipv, err := IPString2Long(va)
			if err != nil {
				log.Println(va, err)
			}

			if ipv > ipi {
				break
			}
		}
	}
	return rs
}

func IPInet(ip string, cidr string) (r bool) {
	ipx, subnet, _ := net.ParseCIDR(cidr)
	ipa := net.ParseIP(ip)
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
