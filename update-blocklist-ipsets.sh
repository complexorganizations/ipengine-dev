#!/bin/bash

# Pre-Checks
function check-system-requirements() {
    # System requirements (git)
    if ! [ -x "$(command -v git)" ]; then
        echo "Error: git is not installed, please install git." >&2
        exit
    fi
}

# Run the function and check for requirements
check-system-requirements

function update-blocklist-ipsets() {
    git clone https://github.com/firehol/blocklist-ipsets.git
    rm -f blocklist-ipsets/*.md && rm -f blocklist-ipsets/*.sh && rm -f blocklist-ipsets/.gitignore && rm -rf blocklist-ipsets/* && cp ipengine.dev blocklist-ipsets/ipengine.dev && ./blocklist-ipsets/ipengine.dev && mv blocklist-ipsets/output.json AppEngine/api.ipengine.dev/output.json && rm -rf blocklist-ipsets
}

# Run the function
update-blocklist-ipsets
