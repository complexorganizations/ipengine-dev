#!/bin/bash

## Sanity Checks and automagic
function root-check() {
if [ "$EUID" -ne 0 ]; then
  echo "Sorry, you need to run this as root"
  exit
fi
}

## Root Check
root-check

function install-essentials() {
  apt-get update
  apt-get upgrade -y
  apt-get dist-upgrade -y
  apt-get install build-essential nginx php7.3-fpm curl -y
  ## Auto Clean
  apt-get autoremove -y
  apt-get autoclean -y
}

## Install Essentials
install-essentials

function install-firewall() {
  apt-get install iptables iptables-persistent ufw fail2ban -y
  ufw allow "http"
  ufw allow "https"
  ufw allow "ssh"
  ufw default deny incoming
  ufw default allow outgoing
  ufw enable
  service fail2ban enable
}

# Firewall Install
install-firewall

function nginx-conf() {
  sed -i "s|# server_tokens off;|server_tokens off;|" /etc/nginx/nginx.conf
  sed -i "s|index index.html index.htm index.nginx-debian.html;|index index.php;"
  service nginx restart
  service php7.3-fpm restart
  chown www-data:www-data  -R *
  find /var/www/html -type d -exec chmod 755 {} \;
  find /var/www/html -type f -exec chmod 644 {} \;
}

# Nginx Config
nginx-conf

function website-config() {
  rm /var/www/html/index.nginx-debian.html
  curl https://raw.githubusercontent.com/complexorganizations/ipengine-dev/master/www/index.php -o /var/www/html/index.php
  curl https://raw.githubusercontent.com/complexorganizations/ipengine-dev/master/www/robots.txt -o /var/www/html/robots.txt
  curl https://raw.githubusercontent.com/complexorganizations/ipengine-dev/master/www/sitemap.xml -o /var/www/html/sitemap.xml
}

website-config

function ssl-nginx() {
  apt-get update
  apt-get install software-properties-common
  add-apt-repository universe
  add-apt-repository ppa:certbot/certbot
  apt-get update
  apt-get install certbot python-certbot-nginx
  certbot --nginx
  certbot renew --dry-run
}

ssl-nginx