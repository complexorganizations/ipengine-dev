### Shell
```
curl 'https://api.ipengine.dev'
```

---

### Ruby
```
require 'net/http'
puts Net::HTTP.get(URI('https://api.ipengine.dev'))
```

---

### Python
```
from requests import get
print get('https://api.ipengine.dev').text
```

---

### Php
```
echo file_get_contents('https://api.ipengine.dev')
```

---

### Node.js
```
var https = require('https');

https.get('https://api.ipengine.dev', function(resp){
    var body = ''
    resp.on('data', function(data){
        body += data;
    });

    resp.on('end', function(){
        console.log(body);
    });
});
```

---

### jQuery
```
$.get('https://api.ipengine.dev', function(data){
  console.log(data)
})
```

---

### Go
```
Go
```

---

### Python
```
Python
```

---

### Java
```
Java
```

---

### C#
```
C#
```

---

### PHP
```
PHP
```

---

### C++
```
C++
```

---

### C
```
C
```

---

### Ruby
```
require 'uri'
require 'net/http'

url = URI("https://api.ipengine.dev")

http = Net::HTTP.new(url.host, url.port)

request = Net::HTTP::Get.new(url)

response = http.request(request)
puts response.read_body
```

---

### Swift
```
Swift
```

---

### Scala
```
Scala
```

---

### Rust
```
Rust
```

---

### Kotlin
```
Kotlin
```

---

### Dart
```
Dart
```

---

### Objective-C
```
Objective-C
```

---

### Perl
```
Perl
```

---

### PowerShell
```
PowerShell
```

---

### .net
```
.net
```

---

### Haskell
```
Haskell
```

---

### JavaScript
```
var request = new XMLHttpRequest();

request.open('GET', 'https://api.ipengine.dev');

request.setRequestHeader('Accept', 'application/json');

request.onreadystatechange = function () {
  if (this.readyState === 4) {
    console.log(this.responseText);
  }
};

request.send();
```

---
