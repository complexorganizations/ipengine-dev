---
title: Languages
---

### Shell

``` sh
curl --silent --location --request GET 'https://api.ipengine.dev'
```

### Ocml

``` ocaml
open Lwt
open Cohttp
open Cohttp_lwt_unix

let reqBody =
  let uri = Uri.of_string "https://api.ipengine.dev" in
  Client.call `GET uri >>= fun (resp, body) ->
  body |> Cohttp_lwt.Body.to_string >|= fun body -> body

let () =
  let respBody = Lwt_main.run reqBody in
  print_endline (respBody)
```

### Ruby

``` rb
require "uri"
require "net/http"

url = URI("https://api.ipengine.dev")

https = Net::HTTP.new(url.host, url.port);
https.use_ssl = true

request = Net::HTTP::Get.new(url)

response = https.request(request)
puts response.read_body
```

### HTTP

``` http
GET / HTTP/1.1
Host: api.ipengine.dev
```

### Python

``` py
import requests

url = "https://api.ipengine.dev"

payload = {}
headers= {}

response = requests.request("GET", url, headers=headers, data = payload)

print(response.text.encode('utf8'))
```

### PHP

``` php
<?php

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => "https://api.ipengine.dev",
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => "",
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => "GET",
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;
```

### Node.js

``` js
var https = require('follow-redirects').https;
var fs = require('fs');

var options = {
    'method': 'GET',
    'hostname': 'api.ipengine.dev',
    'path': '/',
    'headers': {},
    'maxRedirects': 1
};

var req = https.request(options, function(res) {
    var chunks = [];

    res.on("data", function(chunk) {
        chunks.push(chunk);
    });

    res.on("end", function(chunk) {
        var body = Buffer.concat(chunks);
        console.log(body.toString());
    });

    res.on("error", function(error) {
        console.error(error);
    });
});

req.end();
```

### jQuery

``` js
var settings = {
    "url": "https://api.ipengine.dev",
    "method": "GET",
    "timeout": 0,
};

$.ajax(settings).done(function(response) {
    console.log(response);
});
```

### Go

``` go
package main

import (
  "fmt"
  "net/http"
  "io/ioutil"
)

func main() {

  url := "https://api.ipengine.dev"
  method := "GET"

  client := &http.Client {
  }
  req, err := http.NewRequest(method, url, nil)

  if err != nil {
    fmt.Println(err)
  }
  res, err := client.Do(req)
  defer res.Body.Close()
  body, err := ioutil.ReadAll(res.Body)

  fmt.Println(string(body))
}
```

### Java

``` java
OkHttpClient client = new OkHttpClient().newBuilder()
  .build();
Request request = new Request.Builder()
  .url("https://api.ipengine.dev")
  .method("GET", null)
  .build();
Response response = client.newCall(request).execute();
```

### C#

``` cs
var client = new RestClient("https://api.ipengine.dev");
client.Timeout = -1;
var request = new RestRequest(Method.GET);
IRestResponse response = client.Execute(request);
Console.WriteLine(response.Content);
```

### C

``` c
CURL *curl;
CURLcode res;
curl = curl_easy_init();
if(curl) {
  curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, "GET");
  curl_easy_setopt(curl, CURLOPT_URL, "https://api.ipengine.dev");
  curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
  curl_easy_setopt(curl, CURLOPT_DEFAULT_PROTOCOL, "https");
  struct curl_slist *headers = NULL;
  curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
  res = curl_easy_perform(curl);
}
curl_easy_cleanup(curl);
```

### Swift

``` swift
import Foundation

var semaphore = DispatchSemaphore (value: 0)

var request = URLRequest(url: URL(string: "https://api.ipengine.dev")!,timeoutInterval: Double.infinity)
request.httpMethod = "GET"

let task = URLSession.shared.dataTask(with: request) { data, response, error in
  guard let data = data else {
    print(String(describing: error))
    return
  }
  print(String(data: data, encoding: .utf8)!)
  semaphore.signal()
}

task.resume()
semaphore.wait()
```

### Objective-C

``` m
#import <Foundation/Foundation.h>

dispatch_semaphore_t sema = dispatch_semaphore_create(0);

NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.ipengine.dev"]
  cachePolicy:NSURLRequestUseProtocolCachePolicy
  timeoutInterval:10.0];

[request setHTTPMethod:@"GET"];

NSURLSession *session = [NSURLSession sharedSession];
NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
  if (error) {
    NSLog(@"%@", error);
  } else {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    NSError *parseError = nil;
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
    NSLog(@"%@",responseDictionary);
    dispatch_semaphore_signal(sema);
  }
}];
[dataTask resume];
dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
```

### PowerShell

``` ps
$response = Invoke-RestMethod 'https://api.ipengine.dev' -Method 'GET' -Headers $headers -Body $body
$response | ConvertTo-Json
```

### JavaScript

``` js
var requestOptions = {
    method: 'GET',
    redirect: 'follow'
};

fetch("https://api.ipengine.dev", requestOptions)
    .then(response => response.text())
    .then(result => console.log(result))
    .catch(error => console.log('error', error));
```
