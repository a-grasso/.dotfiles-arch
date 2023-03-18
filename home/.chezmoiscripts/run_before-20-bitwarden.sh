#!/bin/bash

# Bitwarden session
sudo -u "$(whoami)" bash -c "export BW_SESSION=$(bw login --raw)"
bw sync
