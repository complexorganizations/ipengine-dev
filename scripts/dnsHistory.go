package main

import (
	"fmt"
	"net"
)

func ipLookup() {
	iprecords, _ := net.LookupIP("facebook.com")
	for _, ip := range iprecords {
		fmt.Println(ip)
	}
}

func cnameLookup() {
	cname, _ := net.LookupCNAME("facebook.com")
	fmt.Println(cname)
}

func ptrLookup() {
	ptr, _ := net.LookupAddr("6.8.8.8")
	for _, ptrvalue := range ptr {
		fmt.Println(ptrvalue)
	}
}

func nameserverLoookup() {
	nameserver, _ := net.LookupNS("facebook.com")
	for _, ns := range nameserver {
		fmt.Println(ns)
	}
}

func mxLookup() {
	mxrecords, _ := net.LookupMX("facebook.com")
	for _, mx := range mxrecords {
		fmt.Println(mx.Host, mx.Pref)
	}
}

func srvLookup() {
	cname, srvs, err := net.LookupSRV("xmpp-server", "tcp", "golang.org")
	if err != nil {
		panic(err)
	}
	fmt.Printf("\ncname: %s \n\n", cname)
	for _, srv := range srvs {
		fmt.Printf("%v:%v:%d:%d\n", srv.Target, srv.Port, srv.Priority, srv.Weight)
	}
}

func txtLookup() {
	txtrecords, _ := net.LookupTXT("facebook.com")
	for _, txt := range txtrecords {
		fmt.Println(txt)
	}
}

func main() {
	ipLookup()
	cnameLookup()
	ptrLookup()
	nameserverLoookup()
	mxLookup()
	srvLookup()
	txtLookup()
}
