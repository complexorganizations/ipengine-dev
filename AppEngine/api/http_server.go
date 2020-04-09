package main

import (
	"errors"
	"fmt"
	"net/http"
	"time"

	log "github.com/ermanimer/logger"
	"github.com/gin-gonic/contrib/cors"
	"github.com/gin-gonic/gin"
)

func startHttpServer(c *Configuration) error {
	//disable degub mod for gin
	gin.SetMode(gin.ReleaseMode)
	//router
	r := gin.New()
	//cross-origin resource sharing
	r.Use(cors.Default())
	//routes
	r.GET("/ip/:ip_address", getIpInformationHandler)
	//http server
	s := http.Server{
		Addr:           fmt.Sprintf("%v:%v", c.IpAddress, c.Port),
		Handler:        r,
		ReadTimeout:    15 * time.Second,
		WriteTimeout:   15 * time.Second,
		MaxHeaderBytes: 1048576,
	}
	log.Info("http server started.")
	err := s.ListenAndServe()
	log.Debugf("startHttpServer: %v", err.Error())
	return errors.New("http server failed!")
}

func getIpInformationHandler(c *gin.Context) {
	//ip address
	ip := c.Param("ip_address")
	//ip information
	ii, err := getIpInformation(c, ip)
	if err != nil {
		log.Error(err.Error())
		c.JSON(http.StatusInternalServerError, gin.H{
			"error_message": err.Error(),
		})
		return
	}
	//response
	c.JSON(http.StatusOK, ii)
}
