# IP Information

{% api-method method="get" host="https://api.ipengine.dev" path="/ip/8.8.8.8" %}
{% api-method-summary %}
Custom IPv4
{% endapi-method-summary %}

{% api-method-description %}
This endpoint allows you to get free cakes.
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-path-parameters %}
{% api-method-parameter name="ip" type="string" required=true %}
Please provide the IPv4 that u need the info on.
{% endapi-method-parameter %}
{% endapi-method-path-parameters %}

{% api-method-headers %}
{% api-method-parameter name="Authentication" type="string" required=false %}
Authentication token to track down who is emptying our stocks.
{% endapi-method-parameter %}
{% endapi-method-headers %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}
successfully retrieved.
{% endapi-method-response-example-description %}

```
{
	"network": {
		"ip": "8.8.8.8",
		"hostname": "ip-66-87-125-72.spfdma.spcsdns.net",
		"reverse": "66.87.125.72",
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
{% endapi-method-response-example %}

{% api-method-response-example httpCode=404 %}
{% api-method-response-example-description %}
Could not find this query.
{% endapi-method-response-example-description %}

```
{"message": "Error could not find this query."}
```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}

{% api-method method="get" host="https://api.ipengine.dev" path="/ip/2001:4860:4860::8888" %}
{% api-method-summary %}
Custom IPv6
{% endapi-method-summary %}

{% api-method-description %}

{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-path-parameters %}
{% api-method-parameter name="ip" type="string" required=true %}
Please provide the IPv6 that u need the info on.
{% endapi-method-parameter %}
{% endapi-method-path-parameters %}

{% api-method-headers %}
{% api-method-parameter name="Authentication" type="string" required=false %}
Authentication token to track down who is emptying our stocks.
{% endapi-method-parameter %}
{% endapi-method-headers %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}

{% endapi-method-response-example-description %}

```
{
	"network": {
		"ip": "2001:4860:4860::8888",
		"hostname": "null",
		"reverse": "null",
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
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}



