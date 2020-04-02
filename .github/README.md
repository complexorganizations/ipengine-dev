# ipengine-dev

### How to Deploy

```
echo "deb http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install google-cloud-sdk git -y
gcloud init
apt-get install google-cloud-sdk-app-engine-go -y
git clone https://github.com/complexorganizations/ipengine-dev.git
cd ipengine-dev
gcloud app deploy
```

### Usage
```
curl -4 https://ipengine.dev
curl -6 https://ipengine.dev
```

## Dev
```
cd /tmp/
curl https://dl.google.com/go/go1.14.1.linux-amd64.tar.gz --create-dirs -o /tmp/go1.14.1.linux-amd64.tar.gz
tar -xvf go1.14.1.linux-amd64.tar.gz
mv go /usr/local
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
source ~/.profile
go version
rm /tmp/go1.14.1.linux-amd64.tar.gz
rm -rf /tmp/go
git clone https://github.com/complexorganizations/ipengine-dev.git
cd ipengine-dev
```

### To Do List
```
Get Hostname From IP https://github.com/complexorganizations/ipengine-dev/issues/7
Get IP From Hostname https://github.com/complexorganizations/ipengine-dev/issues/8
Get Network From Hostname https://github.com/complexorganizations/ipengine-dev/issues/10
```

### Paid Plans
```
Scan a (IP|Hostname) for open port
Test if host is reachable on certain port
```
