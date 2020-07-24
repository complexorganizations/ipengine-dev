#!/bin/bash

# Pre-Checks
function check-system-requirements() {
    # System requirements (git)
    if ! [ -x "$(command -v git)" ]; then
        echo "Error: git is not installed, please install git." >&2
        exit
    fi
    # System requirements (go)
    if ! [ -x "$(command -v go)" ]; then
        echo "Error: go is not installed, please install go." >&2
        exit
    fi
}

# Run the function and check for requirements
check-system-requirements

# Detect Operating System
function dist-check() {
    # shellcheck disable=SC1090
    if [ -e /etc/os-release ]; then
        # shellcheck disable=SC1091
        source /etc/os-release
        DISTRO=$ID
    fi
}

# Check Operating System
dist-check

function update-blocklist-ipsets() {
    # Update begins here
    if ([ "$DISTRO" == "ubuntu" ] || [ "$DISTRO" == "debian" ]); then
        git clone https://github.com/firehol/blocklist-ipsets.git
        cp main.go blocklist-ipsets/main.go
        mv blocklist-ipsets/geolite2_country/* blocklist-ipsets/ && mv blocklist-ipsets/ip2location_country/* blocklist-ipsets/ && mv blocklist-ipsets/ipdeny_country/* blocklist-ipsets/ && mv blocklist-ipsets/ipip_country/* blocklist-ipsets/
        rm -rf blocklist-ipsets/geolite2_country && rm -rf blocklist-ipsets/ip2location_country && rm -rf blocklist-ipsets/ipdeny_country && rm -rf blocklist-ipsets/ipip_country
        cd blocklist-ipsets && go run main.go && cd ../
        mv blocklist-ipsets/output.json AppEngine/api.ipengine.dev/output.json
        rm -rf blocklist-ipsets
    fi
}

# Run the function
update-blocklist-ipsets
