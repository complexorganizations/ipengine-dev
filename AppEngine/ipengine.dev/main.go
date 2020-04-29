package main

import (
	"html/template"
)

func main() {
	http.HandleFunc("/", NAME_HERE)
	if err := http.ListenAndServe(":8080", nil); err != nil {
		panic(err)
	}
}
