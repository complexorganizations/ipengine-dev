package main

import log "github.com/ermanimer/logger"

func main() {
	//logger
	log.Initialize("logs", log.DebugTraceLevel)
	//configuration
	c, err := getConfiguration()
	if err != nil {
		log.Fatal(err.Error())
	}
	//http server
	err = startHttpServer(c)
	log.Fatal(err.Error())
}
