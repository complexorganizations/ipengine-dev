package main

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"log"
	"net"
	"net/http"
	"os"
	"strings"
	"sync"

	"api.ipengine.dev/api"
	"github.com/openrdap/rdap"
	"github.com/oschwald/geoip2-golang"
	"google.golang.org/grpc"
	"google.golang.org/grpc/peer"
)

/*
- 1. Make a new object named location
- 2. under location add Country/City info
- 3. under network add ASN info
- 4. make sure we have all the info
- 5. turn REST into GRPC
- 6. Once done; please go here (https://github.com/complexorganizations/disposable-services) and look at the main.go and the next tasks are there.
*/

const (
	HTTPPort  = ":8080"
	gRPCPort  = ":8081"
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
		log.Fatal(err)
	}
	defer func() { _ = asn.Close() }()

	city, err := geoip2.Open("GeoLite2-City.mmdb")
	if err != nil {
		log.Fatal(err)
	}
	defer func() { _ = city.Close() }()

	country, err := geoip2.Open("GeoLite2-Country.mmdb")
	if err != nil {
		log.Fatal(err)
	}
	defer func() { _ = country.Close() }()

	asnDB = asn
	cityDB = city
	countryDB = country

	blockIPs = LoadBlockIPs(IPSetFile)

	service := NewService()
	httpServer := NewHttpServer(service)
	grpcServer := NewGrpcServer(service)

	var wg sync.WaitGroup
	wg.Add(2)

	go func() {
		err := httpServer.Run(HTTPPort)
		if err != nil {
			log.Println(err)
		}
		wg.Done()
	}()
	go func() {
		err := grpcServer.Run(gRPCPort)
		if err != nil {
			log.Println(err)
		}
		wg.Done()
	}()

	wg.Wait()
}

type HttpServer struct {
	router *http.ServeMux
	srv    Service
}

func NewHttpServer(srv Service) *HttpServer {
	r := http.NewServeMux()
	return &HttpServer{
		router: r,
		srv:    srv,
	}
}

func (s HttpServer) Run(port string) error {
	log.Println("Starting HTTP server in port:", port)

	s.router.HandleFunc("/", s.ReverseIPHandler(s.srv))
	s.router.HandleFunc("/ip/", s.IPHandler(s.srv))

	return http.ListenAndServe(port, s.router)
}

func (s *HttpServer) Write(writer http.ResponseWriter, data interface{}) error {
	return json.NewEncoder(writer).Encode(data)
}

func (s *HttpServer) WriteError(writer http.ResponseWriter, status int) {
	http.Error(writer, http.StatusText(status), status)
}

func (s *HttpServer) ReverseIPHandler(srv Service) http.HandlerFunc {
	return func(writer http.ResponseWriter, request *http.Request) {
		writer.Header().Set("Content-Type", "application/json")

		ip := GetReverseIP(request)
		if ip == nil {
			s.WriteError(writer, http.StatusNotFound)
			return
		}

		resp, _ := srv.ReverseIP(ip)

		err := s.Write(writer, resp)
		if err != nil {
			log.Println(err)
		}
	}
}

func (s *HttpServer) IPHandler(srv Service) http.HandlerFunc {
	return func(writer http.ResponseWriter, request *http.Request) {
		writer.Header().Set("Content-Type", "application/json")

		ip, err := GetIPFromParameter(request)
		if err != nil || ip == nil {
			log.Println(err)
			s.WriteError(writer, http.StatusNotFound)
			return
		}

		resp, _ := srv.IP(ip)

		err = s.Write(writer, resp)
		if err != nil {
			log.Println(err)
		}
	}
}

type GrpcServer struct {
	server *grpc.Server
	srv    Service
}

func NewGrpcServer(srv Service) *GrpcServer {
	server := grpc.NewServer()

	serverHandler := &GrpcServer{
		server: server,
		srv:    srv,
	}

	api.RegisterIPEngineServiceServer(server, serverHandler)

	return serverHandler
}

func (s GrpcServer) Run(port string) error {
	log.Println("Starting gRPC server in port:", port)

	lis, err := net.Listen("tcp", port)
	if err != nil {
		return err
	}

	return s.server.Serve(lis)
}

func (s GrpcServer) ReverseIP(ctx context.Context, in *api.ReverseIPRequest) (*api.Response, error) {
	p, ok := peer.FromContext(ctx)
	if !ok {
		return nil, errors.New("no peer available")
	}

	ip := GetIP(p.Addr.String())
	resp, err := s.srv.ReverseIP(ip)
	if err != nil {
		return nil, err
	}

	return resp.Proto(), nil
}

func (s GrpcServer) IP(ctx context.Context, in *api.IPRequest) (*api.Response, error) {
	ip := net.ParseIP(in.GetIp())

	resp, err := s.srv.IP(ip)
	if err != nil {
		return nil, err
	}

	return resp.Proto(), nil
}

type Service struct{}

func NewService() Service {
	return Service{}
}

func (s Service) ReverseIP(ip net.IP) (*Response, error) {
	return NewResponse(ip), nil
}

func (s Service) IP(ip net.IP) (*Response, error) {
	rsp := NewResponse(ip)
	rsp.Analysis = blockIPs.Analyse(ip.String())
	return rsp, nil
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

type Response struct {
	Network      NetworkInfo      `json:"network,omitempty"`
	Location     Location         `json:"location,omitempty"`
	Arin         ArinInfo         `json:"arin,omitempty"`
	Organization OrganizationInfo `json:"organization,omitempty"`
	Contact      ContactInfo      `json:"contact,omitempty"`
	Abuse        ContactInfo      `json:"abuse,omitempty"`
	Analysis     AnalysisResult   `json:"analysis,omitempty"`
}

func NewResponse(ip net.IP) *Response {
	response := &Response{
		Network:  ParseNetWork(ip),
		Location: ParseLocation(ip),
	}

	c := &rdap.Client{}
	network, err := c.QueryIP(ip.String())
	if err != nil {
		return response
	}

	response.Arin = ParseArin(network)

	org, cont, abuse := ParseEntities(network)
	response.Organization = org
	response.Contact = cont
	response.Abuse = abuse

	return response
}

func (r *Response) Proto() *api.Response {
	return &api.Response{
		Network:      r.Network.Proto(),
		Location:     r.Location.Proto(),
		Arin:         r.Arin.Proto(),
		Organization: r.Organization.Proto(),
		Contact:      r.Contact.Proto(),
		Abuse:        r.Abuse.Proto(),
		Analysis:     r.Analysis.Proto(),
	}
}

type NetworkInfo struct {
	Ip       string `json:"ip"`
	Hostname string `json:"hostname"`
	Reverse  string `json:"reverse"`
	Asn      string `json:"asn,omitempty"`
}

func ParseNetWork(ip net.IP) NetworkInfo {
	network := NetworkInfo{}
	network.Ip = ip.String()

	host, err := net.LookupAddr(ip.String())
	if err != nil || len(host) == 0 {
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
		return network
	}

	network.Asn = fmt.Sprint(asn.AutonomousSystemNumber)
	return network
}

func (r *NetworkInfo) Proto() *api.NetworkInfo {
	if r == nil {
		return nil
	}

	return &api.NetworkInfo{
		Ip:       r.Ip,
		Hostname: r.Hostname,
		Reverse:  r.Reverse,
		Asn:      r.Asn,
	}
}

type Location struct {
	City    string `json:"city,omitempty"`
	Country string `json:"country,omitempty"`
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

func (r *Location) Proto() *api.Location {
	if r == nil {
		return nil
	}

	return &api.Location{
		City:    r.City,
		Country: r.Country,
	}
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

func ParseArin(network *rdap.IPNetwork) ArinInfo {
	arin := ArinInfo{}

	arin.Name = network.Name
	arin.Cidr = network.Handle
	arin.Handle = network.Handle
	arin.Parent = network.ParentHandle
	arin.Range = network.StartAddress + "-" + network.EndAddress
	arin.Type = network.Type

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

func (r *ArinInfo) Proto() *api.ArinInfo {
	if r == nil {
		return nil
	}

	return &api.ArinInfo{
		Name:         r.Name,
		Handle:       r.Handle,
		Parent:       r.Parent,
		Type:         r.Type,
		Range:        r.Range,
		Cidr:         r.Cidr,
		Status:       r.Status,
		Registration: r.Registration,
		Updated:      r.Updated,
	}
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

func ParseEntities(network *rdap.IPNetwork) (OrganizationInfo, ContactInfo, ContactInfo) {
	org := OrganizationInfo{}
	contact := ContactInfo{}
	abuse := ContactInfo{}

	for _, ent := range network.Entities {
		if ent.VCard == nil {
			continue
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
		// abuse information
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

func (r *OrganizationInfo) Proto() *api.OrganizationInfo {
	if r == nil {
		return nil
	}

	return &api.OrganizationInfo{
		Name:         r.Name,
		Handle:       r.Handle,
		Street:       r.Street,
		City:         r.City,
		Province:     r.Province,
		Postal:       r.Postal,
		Country:      r.Country,
		Registration: r.Registration,
		Updated:      r.Updated,
	}
}

func (r *ContactInfo) Proto() *api.ContactInfo {
	if r == nil {
		return nil
	}

	return &api.ContactInfo{
		Name:         r.Name,
		Handle:       r.Handle,
		Company:      r.Company,
		Street:       r.Street,
		City:         r.City,
		Province:     r.Province,
		Postal:       r.Postal,
		Country:      r.Country,
		Registration: r.Registration,
		Updated:      r.Updated,
		Phone:        r.Phone,
		Email:        r.Email,
	}
}

func HasRole(src []string, item string) bool {
	for _, v := range src {
		if v == item {
			return true
		}
	}
	return false
}

type BlockIP map[string][]string

type AnalysisResult map[string]bool

func LoadBlockIPs(fileName string) BlockIP {
	blockIps := BlockIP{}

	file, err := os.Open(fileName)
	if err != nil {
		return blockIps
	}

	blockIps.Load(file)
	return blockIps
}

func (bip *BlockIP) Load(file io.Reader) {
	if err := json.NewDecoder(file).Decode(bip); err != nil {
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

			ipi, _ := IPString2Long(ip)
			ipv, _ := IPString2Long(va)

			if ipv > ipi {
				break
			}
		}
	}

	return rs
}

func (r AnalysisResult) Proto() map[string]bool {
	return r
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
