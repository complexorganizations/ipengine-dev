### Getting IPv6
---


```
$ curl -6 https://api.ipengine.dev
```

```
{
	"network": {
		"ip": "2604:2000:1500:8fc8:f0e8:755d:767b:ef7f",
		"hostname": "null",
		"reverse": "null",
		"user_agent": "PostmanRuntime/7.24.1",
		"location": {
			"country": "United States of America",
			"province": "New York",
			"city": "Flushing",
			"postal": "01105",
			"location": "42.0999,-72.5783",
			"timezone": "America/New_York",
			"language": "English",
			"currency": "United States Dollar"
		},
		"analysis": {
			"anonymizers": "true",
			"abuse": "false",
			"malware": "true",
			"organizations": "true",
			"spam": "true",
			"unroutable": "true"
		}
	},
	"arin": {
		"name": "rrny",
		"handle": "NET-69-200-0-0-1",
		"parent": "NET69 (NET-69-0-0-0-0)",
		"type": "Direct Allocation",
		"range": "69.200.0.0 - 69.207.255.255",
		"cidr": "69.200.0.0/13",
		"registration": "2004-03-26",
		"updated": "2006-06-06",
		"organization": {
			"name": "Charter Communications Inc",
			"handle": "cc-3517",
			"street": "6399 S. Fiddler's Green Circle",
			"city": "Greenwood Village",
			"province": "CO",
			"postal": "80111",
			"country": "United States of America",
			"registration": "2004-03-26",
			"updated": "2006-06-06"
		},
		"contact": {
			"name": "Company Name",
			"handle": "IPADD1-ARIN",
			"company": "Charter Communications",
			"street": "6399 S. Fiddler's Green Circle",
			"city": "Greenwood Village",
			"province": "CO",
			"postal": "80111",
			"country": "United States of America",
			"registration": "2004-03-26",
			"updated": "2006-06-06",
			"phone": "212-121-2121",
			"email": "test@example.com"
		},
		"abuse": {
			"name": "Abuse",
			"handle": "ABUSE10-ARIN",
			"street": "6399 S. Fiddler's Green Circle",
			"city": "Greenwood Village",
			"province": "CO",
			"postal": "80111",
			"country": "United States of America",
			"registration": "2004-03-26",
			"updated": "2006-06-06",
			"phone": "212-121-2121",
			"email": "test@example.com"
		}
	}
}
```
