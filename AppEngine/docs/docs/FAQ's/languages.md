### Shell
```sh
curl 'https://api.ipengine.dev'
```

---

### Ruby
```rb
require 'net/http'
puts Net::HTTP.get(URI('https://api.ipengine.dev'))
```

---

### Python
```py
from requests import get
print get('https://api.ipengine.dev').text
```

---

### Php
```php
echo file_get_contents('https://api.ipengine.dev')
```

---

### Node.js
```js
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
```js
$.get('https://api.ipengine.dev', function(data){
  console.log(data)
})
```

---

### Go
```go
Go
```

---

### Java
```java
Java
```

---

### C#
```cs
C#
```

---

### C++
```cpp
C++
```

---

### C
```c
C
```

---

### Ruby
```rb
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
```swift
Swift
```

---

### Scala
```
Scala
```

---

### Rust
```rs
Rust
```

---

### Kotlin
```
Kotlin
```

---

### Dart
```dart
Dart
```

---

### Objective-C
```m
Objective-C
```

---

### Perl
```pl
Perl
```

---

### PowerShell
```ps1
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
```js
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
