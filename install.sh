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
    apt-get install build-essential -y
    apt-get install nginx php7.3-fpm -y
    ## Auto Clean
    apt-get autoremove -y
    apt-get autoclean -y
}

## Install Essentials
install-essentials


function firewall() {
    apt-get install iptables iptables-persistent ufw fail2ban -y
    ufw allow "http"
    ufw allow "https"
    ufw allow "ssh"
    ufw default deny incoming
    ufw default allow outgoing
    ufw enable
}

function nginx-conf() {
  sed -i "s|# server_tokens off;|server_tokens off;|" /etc/nginx/nginx.conf
  service nginx restart
  service php7.3-fpm restart
  chown www-data:www-data  -R *
  find /var/www/html -type d -exec chmod 755 {} \;
  find /var/www/html -type f -exec chmod 644 {} \;
}

cd /var/www/html/
wget https://raw.githubusercontent.com/complexorganizations/ipengine-dev/master/index.php

function ssl-nginx() {
  sudo apt-get update
  sudo apt-get install software-properties-common
  sudo add-apt-repository universe
  sudo add-apt-repository ppa:certbot/certbot
  sudo apt-get update
  sudo apt-get install certbot python-certbot-nginx
  sudo certbot --nginx
  sudo certbot renew --dry-run
}
