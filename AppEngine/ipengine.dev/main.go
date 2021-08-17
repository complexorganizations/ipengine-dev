package main

import (
	"log"
	"net/http"
)

var (
	err        error
	filePath   = "www"
	serverPort = ":8080"
)

func main() {
	http.Handle("/", http.FileServer(http.Dir(filePath)))
	err = http.ListenAndServe(serverPort, nil)
	if err != nil {
		log.Println(err)
	}
}
