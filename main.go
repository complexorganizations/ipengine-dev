package main

import (
	"encoding/json"
	"net"
	"net/http"
	"strconv"
	"time"
)

type Interface struct {
	Index        int    // positive integer that starts at one, zero is never used
	MTU          int    // maximum transmission unit
	Name         string // e.g., "en0", "lo0", "eth0.100"
	HardwareAddr string // IEEE MAC-48, EUI-48 and EUI-64 form
	Flags        string
	Addr         []string // e.g., FlagUp, FlagLoopback, FlagMulticast
}

type PortScanner struct {
	Port   int
	Status string
}

func main() {
	http.HandleFunc("/", ExampleHandler)
	if err := http.ListenAndServe(":8080", nil); err != nil {
		panic(err)
	}
}

func ExampleHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Add("Content-Type", "application/json")

	ip := GetIP(r)
	resp := map[string]interface{}{
		"ip":         ip,
		"user_agent": r.Header.Get("User-Agent"),
	}
	hostname, err := GetHostName(ip)
	if err != nil {
		resp["hostname"] = hostname
	}
	aadr, net := GetNetwork(hostname[0])

	resp["address"] = aadr
	resp["network"] = net

	resp["interface"] = GetInterfaces()
	resp["ports"] = Getport(ip)
	resp["interface_addr"] = Getifaceaddresses()
	resp["reverse_ip"] = GetReverseIp(hostname[0])
	resp["host_reachable"] = isReachable(hostname[0])

	b, _ := json.Marshal(resp)

	w.Write(b)
}

// GetIP gets a requests IP address by reading off the forwarded-for
// header (for proxies) and falls back to use the remote address.
func GetIP(r *http.Request) string {
	forwarded := r.Header.Get("CF-CONNECTING-IP")
	if forwarded != "" {
		return forwarded
	}
	return r.RemoteAddr
}

func GetHostName(ip string) ([]string, error) {
	host, err := net.LookupAddr(ip)
	return host, err
}

func GetNetwork(hostname string) (string, string) {
	IPAddr, _ := net.ResolveIPAddr("ip", hostname)
	addr := net.ParseIP(IPAddr.String())
	// DefaultMask returns the default IP mask for the IP address ip.
	mask := addr.DefaultMask()
	// Mask returns the result of masking the IP address ip with mask.
	network := addr.Mask(mask)
	return addr.String(), network.String()
}

func GetInterfaces() []Interface {

	var ifaces []Interface
	interfaces, _ := net.Interfaces()
	for _, inter := range interfaces {
		addrs, _ := inter.Addrs()
		var address []string
		for _, ipaddr := range addrs {
			address = append(address, ipaddr.String())
		}
		iface := Interface{
			Index:        inter.Index,
			MTU:          inter.MTU,
			Name:         inter.Name,
			HardwareAddr: inter.HardwareAddr.String(),
			Flags:        inter.Flags.String(),
			Addr:         address,
		}
		ifaces = append(ifaces, iface)
	}
	return ifaces
}

func Getport(ip string) []PortScanner {

	var ports []PortScanner

	for i := 1; i < 65535; i++ {
		port := strconv.FormatInt(int64(i), 10)
		conn, err := net.Dial("tcp", ip+":"+port)
		if err == nil {
			ports = append(ports, PortScanner{
				Port:   i,
				Status: "open",
			})
			_ = conn.Close()
		}
	}

	return ports
}

func Getifaceaddresses() []string {

	var adrr []string
	foo, err := net.InterfaceAddrs()

	if err == nil {
		for _, v := range foo {
			adrr = append(adrr, v.String())
		}
	}
	return adrr
}

func GetReverseIp(host string) interface{} {
	addr, err := net.LookupIP(host)
	if err == nil {
		return addr
	}
	return ""
}

func isReachable(hostname string) bool {
	portNum := "80"
	seconds := 5
	timeOut := time.Duration(seconds) * time.Second

	conn, err := net.DialTimeout("tcp", hostname+":"+portNum, timeOut)
	if err != nil {
		return false
	}
	_ = conn.Close()
	return true
}
