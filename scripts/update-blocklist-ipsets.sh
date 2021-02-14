#!/bin/bash

# Detect Operating System
function dist-check() {
    if [ -e /etc/os-release ]; then
        source /etc/os-release
        DISTRO=$ID
    fi
}

# Check Operating System
dist-check

# Pre-Checks system requirements
function installing-system-requirements() {
  if { [ "$DISTRO" == "ubuntu" ] || [ "$DISTRO" == "debian" ] || [ "$DISTRO" == "raspbian" ] || [ "$DISTRO" == "pop" ] || [ "$DISTRO" == "kali" ] || [ "$DISTRO" == "linuxmint" ] || [ "$DISTRO" == "fedora" ] || [ "$DISTRO" == "centos" ] || [ "$DISTRO" == "rhel" ] || [ "$DISTRO" == "arch" ] || [ "$DISTRO" == "manjaro" ] || [ "$DISTRO" == "alpine" ] || [ "$DISTRO" == "freebsd" ]; }; then
    if { [ ! -x "$(command -v git)" ] || [ ! -x "$(command -v go)" ]; }; then
      if { [ "$DISTRO" == "ubuntu" ] || [ "$DISTRO" == "debian" ] || [ "$DISTRO" == "raspbian" ] || [ "$DISTRO" == "pop" ] || [ "$DISTRO" == "kali" ] || [ "$DISTRO" == "linuxmint" ]; }; then
        apt-get update && apt-get install golang-go git -y
      elif { [ "$DISTRO" == "fedora" ] || [ "$DISTRO" == "centos" ] || [ "$DISTRO" == "rhel" ]; }; then
        yum update -y && yum install golang-go git -y
      elif { [ "$DISTRO" == "arch" ] || [ "$DISTRO" == "manjaro" ]; }; then
        pacman -Syu --noconfirm iptables golang-go git
      elif [ "$DISTRO" == "alpine" ]; then
        apk update && apk add iptables golang-go git
      elif [ "$DISTRO" == "freebsd" ]; then
        pkg update && pkg install golang-go git
      fi
    fi
  else
    echo "Error: $DISTRO not supported."
    exit
  fi
}

# Run the function and check for requirements
installing-system-requirements

# Update the blocklist ipset
function update-blocklist-ipsets() {
    if [ -x "$(command -v go)" ]; then
        git clone https://github.com/firehol/blocklist-ipsets.git
        mv blocklist-ipsets/geolite2_country/* blocklist-ipsets/ && mv blocklist-ipsets/ip2location_country/* blocklist-ipsets/ && mv blocklist-ipsets/ipdeny_country/* blocklist-ipsets/ && mv blocklist-ipsets/ipip_country/* blocklist-ipsets/
        rm -rf blocklist-ipsets/geolite2_country && rm -rf blocklist-ipsets/ip2location_country && rm -rf blocklist-ipsets/ipdeny_country && rm -rf blocklist-ipsets/ipip_country
        cp blockipsUpdate.go blocklist-ipsets/blockipsUpdate.go && cd blocklist-ipsets && go run blockipsUpdate.go && cd ../
        rm -f AppEngine/api.ipengine.dev/blockips.json
        mv blocklist-ipsets/blockips.json AppEngine/api.ipengine.dev/blockips.json
        rm -rf blocklist-ipsets
    else
        echo "Error: In your system, Go wasn't found."
        exit
    fi
}

# Update the blocklist ipset
update-blocklist-ipsets
