## ipengine.xyz: Free and Powerful IP Intelligence

**ipengine.xyz** is a free and open-source service that provides comprehensive IP intelligence data. It aims to be a powerful alternative to existing services like ipinfo.io, offering greater accuracy, detail, and a user-friendly experience.

### Features

* **Free forever:** No hidden fees or limitations.
* **Detailed IP information:** Get data beyond basic geolocation, including network ownership, autonomous system details, and more.
* **Unmatched accuracy:** Leverage a robust infrastructure for highly accurate IP data.
* **Simple and easy-to-use API:** Integrate ipengine.dev seamlessly into your applications.
* **Open-source:** Contribute to the project and benefit from a transparent development process.

### Getting Started

**Using the API:**

1. **Make a request:** Send a GET request to the ipengine.dev API endpoint with the target IP address as a query parameter.
2. **Parse the response:** The response will be a JSON object containing detailed information about the IP address.

**Example Usage (using cURL):**

```bash
curl --location "https://api.ipengine.xyz"
```

```bash
curl --location "https://api.ipengine.xyz" --header "Requested-Ip: 1.1.1.1" --header "Authorization: <auth-token>"
```

**Example Response:**

```json
{
    "network": {
        "ip": "::1",
        "type": "IPv6",
        "decimal": 1,
        "reverse": [
            "::1"
        ],
        "hostname": [
            "localhost",
            "ip6-localhost",
            "ip6-loopback"
        ]
    },
    "device": {
        "user_agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36",
        "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "cache": "max-age=0",
        "accept_encoding": "gzip, deflate, br, zstd"
    },
    "analysis": {
        "abuse": false,
        "anonymizers": false,
        "attacks": false,
        "geolocation": false,
        "malware": false,
        "organizations": false,
        "reputation": false,
        "spam": false,
        "unroutable": false,
        "unspecified": false,
        "private": false,
        "multicast": false,
        "loopback": true,
        "local_unicast": false,
        "local_multicast": false,
        "interface_local_multicast": false,
        "global_unicast": false
    }
}
```


```json
{
    "network": {
        "ip": "1.1.1.1",
        "type": "IPv4",
        "decimal": 16843009,
        "reverse": [
            "1.1.1.1"
        ],
        "hostname": [
            "one.one.one.one"
        ]
    },
    "analysis": {
        "abuse": false,
        "anonymizers": false,
        "attacks": false,
        "geolocation": false,
        "malware": false,
        "organizations": false,
        "reputation": false,
        "spam": false,
        "unroutable": false,
        "unspecified": false,
        "private": false,
        "multicast": false,
        "loopback": false,
        "local_unicast": false,
        "local_multicast": false,
        "interface_local_multicast": false,
        "global_unicast": true
    }
}
```

**Documentation:**

Full API documentation and code samples for various programming languages are coming soon!

### Contributing

We welcome contributions to ipengine.xyz! If you'd like to help improve the service, you can:

* **Report bugs:** Open an issue on the GitHub repository.
* **Suggest features:** Share your ideas for improvement through pull requests.
* **Contribute code:** Fork the repository and submit pull requests for your changes.

Before contributing, please review our contribution guidelines (coming soon).

### License

This project is licensed under the MIT License. See the LICENSE file for more details.

### Social

[![Slack](https://raw.githubusercontent.com/complexorganizations/ipengine-xyz/main/assets/images/icons/slack.svg)](https://join.slack.com/t/complexorgani-w5b4873/shared_invite/zt-2e9gz2wh2-dWuylZLgaEgFywNKF_iQRQ)
[![Discord](https://raw.githubusercontent.com/complexorganizations/ipengine-xyz/main/assets/images/icons/discord.svg)](https://discord.gg/KaB5jBexgm)

### Team

ipengine.xyz is an ongoing project developed by a team of passionate developers. We are committed to providing a valuable and free resource for the developer community.
