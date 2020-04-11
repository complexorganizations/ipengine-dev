### Shell
```sh
curl 'https://api.ipengine.dev'
```

---
### Ruby
```ruby
require 'net/http'
puts Net::HTTP.get(URI('https://api.ipengine.dev'))
```

---
### Python
```python
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
```nodejs
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
```jquery
$.get('https://api.ipengine.dev', function(data){
  console.log(data)
})
```
