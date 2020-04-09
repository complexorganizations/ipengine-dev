package main

import (
	"errors"
	"os"

	log "github.com/ermanimer/logger"
	"gopkg.in/yaml.v3"
)

type Configuration struct {
	IpAddress string `yaml:"ip_address"`
	Port      int    `yaml:"port"`
}

const (
	ConfigurationFile = "configuration.yaml"
)

func getConfiguration() (*Configuration, error) {
	//configuration file
	cf, err := os.Open(ConfigurationFile)
	if err != nil {
		log.Debugf("getConfiguration: %v", err.Error())
		return nil, errors.New("opening configuration file failed!")
	}
	defer cf.Close()
	//configuration
	var c Configuration
	err = yaml.NewDecoder(cf).Decode(&c)
	if err != nil {
		log.Debugf("getConfiguration: %v", err.Error())
		return nil, errors.New("decoding configuration file failed!")
	}
	return &c, nil
}
