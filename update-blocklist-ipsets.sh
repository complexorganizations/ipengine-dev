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
        cp main.go blocklist-ipsets/main.go && go run blocklist-ipsets/main.go && mv blocklist-ipsets/output.json AppEngine/api.ipengine.dev/output.json && rm -rf blocklist-ipsets
    fi
}

# Run the function
update-blocklist-ipsets
