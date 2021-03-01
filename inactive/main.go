package main

import (
	"bufio"
	"encoding/json"
	"io/ioutil"
	"log"
	"os"
	"strings"
)

func main() {
	files, err := ioutil.ReadDir(".")
	if err != nil {
		log.Println(err)
	}
	mainJSON := make(map[string][]string)
	for _, f := range files {
		fName := f.Name()
		if res := strings.Index(fName, "."); res == -1 || (fName[res:] != ".ipset" && fName[res:] != ".netstat") {
			continue
		}
		file, err := os.Open(fName)
		if err != nil {
			log.Println(err)
		}
		mainCat := ""
		scanner := bufio.NewScanner(file)
		for scanner.Scan() {
			txt := scanner.Text()
			catlen := len("# Category")
			if txt[0] != []byte("#")[0] {
				mainJSON[mainCat] = append(mainJSON[mainCat], scanner.Text())
				continue
			}
			if len(txt) >= catlen && txt[:catlen] == "# Category" {
				cat := txt[catlen:]
				catTrim := strings.Trim(cat, " ")
				if catTrim[0] == []byte(":")[0] && len(catTrim) > 2 {
					catTrim = catTrim[2:]
					_, ok := mainJSON[catTrim]
					if !ok {
						mainJSON[catTrim] = []string{}
					}
					mainCat = catTrim
				}
			}
		}
		if err := scanner.Err(); err != nil {
			log.Println(err)
		}
		_ = file.Close()
	}
	data, _ := json.Marshal(mainJSON)
	_ = ioutil.WriteFile("blockips.json", data, 0644)
}
