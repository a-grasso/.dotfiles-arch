#!/bin/bash

# Bitwarden session
sudo -u "$(whoami)" "$(echo $0)" -c "export BW_SESSION=$(bw login --raw)"
bw sync
