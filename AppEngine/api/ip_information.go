package main

import (
	"errors"
	"net"

	"github.com/gin-gonic/gin"

	log "github.com/ermanimer/logger"
)

type IpInformation struct {
	IpAddress        string `json:"ip_address"`
	Hostname         string `json:"hostname"`
	ReverseIpAddress string `json:"reverse_ip_address"`
}

func getIpInformation(c *gin.Context, ipAddress string) (*IpInformation, error) {
	//reverse ip address
	rip := c.ClientIP()
	//hostnames
	hn, err := net.LookupAddr(ipAddress)
	if err != nil {
		log.Debugf("getIpInformation: %v", err.Error())
		return nil, errors.New("looking up for hostnames failed!")
	}
	//ip information
	ii := IpInformation{
		IpAddress:        ipAddress,
		Hostname:         hn[0],
		ReverseIpAddress: rip,
	}
	//log
	log.Infof("[%v][%v][%v]", ii.IpAddress, ii.Hostname, ii.ReverseIpAddress)
	return &ii, nil
}
