### Getting IPv6
---


```
$ curl -6 https://api.ipengine.dev
```

```
{
	"network": {
		"ip": "2604:2000:1500:8fc8:1192:688d:f125:4ff2",
		"hostname": "null",
		"reverse": "null",
		"location": {
			"country": "United States of America",
			"province": "New York",
			"city": "Flushing",
			"postal": "01105",
			"coordinates": "42.0999,-72.5783",
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
			"Kind": "Group",
			"name": "Google LLC",
			"handle": "cc-3517",
			"email": "network-abuse@google.com",
			"telephone": "+1-650-253-0000",
			"organization": "Google LLC",
			"Address": "6399 S. Fiddler's Green Circle, Greenwood Village, CO, 80111, United States of America",
			"Roles": "Abuse"
		},
		"contact": {
			"Kind": "Group",
			"name": "Google LLC",
			"handle": "cc-3517",
			"email": "network-abuse@google.com",
			"telephone": "+1-650-253-0000",
			"organization": "Google LLC",
			"Address": "6399 S. Fiddler's Green Circle, Greenwood Village, CO, 80111, United States of America",
			"Roles": "Abuse"
		},
		"abuse": {
			"Kind": "Group",
			"name": "Google LLC",
			"handle": "cc-3517",
			"email": "network-abuse@google.com",
			"telephone": "+1-650-253-0000",
			"organization": "Google LLC",
			"Address": "6399 S. Fiddler's Green Circle, Greenwood Village, CO, 80111, United States of America",
			"Roles": "Abuse"
		}
	}
}
```