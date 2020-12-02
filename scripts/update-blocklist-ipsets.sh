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

# Pre-Checks
function check-system-requirements() {
    # System requirements (git)
    if ! [ -x "$(command -v git)" ]; then
        echo "Error: git is not installed, please install git." >&2
    fi
    # System requirements (go)
    if ! [ -x "$(command -v go)" ]; then
        echo "Error: go is not installed, please install go." >&2
    fi
}

# Run the function and check for requirements
check-system-requirements

# Update the blocklist ipset
function update-blocklist-ipsets() {
    if ([ "$DISTRO" == "ubuntu" ] || [ "$DISTRO" == "debian" ]); then
        apt-get install golang-go git -y
        git clone https://github.com/firehol/blocklist-ipsets.git
        mv blocklist-ipsets/geolite2_country/* blocklist-ipsets/ && mv blocklist-ipsets/ip2location_country/* blocklist-ipsets/ && mv blocklist-ipsets/ipdeny_country/* blocklist-ipsets/ && mv blocklist-ipsets/ipip_country/* blocklist-ipsets/
        rm -rf blocklist-ipsets/geolite2_country && rm -rf blocklist-ipsets/ip2location_country && rm -rf blocklist-ipsets/ipdeny_country && rm -rf blocklist-ipsets/ipip_country
        cp blockipsUpdate.go blocklist-ipsets/blockipsUpdate.go && cd blocklist-ipsets && go run blockipsUpdate.go && cd ../
        rm -f AppEngine/api.ipengine.dev/blockips.json
        mv blocklist-ipsets/blockips.json AppEngine/api.ipengine.dev/blockips.json
        rm -rf blocklist-ipsets
    fi
}

# Update the blocklist ipset
update-blocklist-ipsets
