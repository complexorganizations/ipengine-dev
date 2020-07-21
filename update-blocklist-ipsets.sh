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
    if [ "$DISTRO" == "ubuntu" ]; then
        git clone https://github.com/firehol/blocklist-ipsets.git
        go build main.go && mv main blocklist-ipsets && rm -rf blocklist-ipsets && cp ipengine.dev blocklist-ipsets/ipengine.dev && ./blocklist-ipsets/ipengine.dev && mv blocklist-ipsets/output.json AppEngine/api.ipengine.dev/output.json && rm -rf blocklist-ipsets
    fi
}

# Run the function
update-blocklist-ipsets
