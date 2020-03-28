# ipengine-dev

### How to Deploy

```
echo "deb http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install google-cloud-sdk git -y
gcloud init
git clone https://github.com/complexorganizations/ipengine-dev.git
cd ipengine-dev
gcloud app deploy
```


### Usage
```
curl -4 https://ipengine.dev
curl -6 https://ipengine.dev
```