package main

import (
	"encoding/json"
	"net"
	"net/http"
	"strings"
)

type Interface struct {
	Index        int    // positive integer that starts at one, zero is never used
	MTU          int    // maximum transmission unit
	Name         string // e.g., "en0", "lo0", "eth0.100"
	HardwareAddr string // IEEE MAC-48, EUI-48 and EUI-64 form
	Flags        string
	Addr         []string // e.g., FlagUp, FlagLoopback, FlagMulticast
}

func main() {
	http.HandleFunc("/", ExampleHandler)
	if err := http.ListenAndServe(":8080", nil); err != nil {
		panic(err)
	}
}

func ExampleHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Add("Content-Type", "application/json")

	addr := GetIP(r)
	addrList := strings.Split(addr, ":")
	ip := addrList[0]

	resp := map[string]interface{}{
		"ip":         GetIP(r),
		"user_agent": r.Header.Get("User-Agent"),
	}
	hostname, err := GetHostName(ip)
	if err == nil {
		resp["hostname"] = hostname[0]
	}
	resp["interface"] = GetInterfaces()
	b, _ := json.Marshal(resp)

	_, _ = w.Write(b)
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
