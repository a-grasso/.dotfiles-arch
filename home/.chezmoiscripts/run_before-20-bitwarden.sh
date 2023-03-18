#!/bin/bash

# Bitwarden session
sudo -u "$(whoami)" zsh -c "export BW_SESSION=$(bw login --raw)"
bw sync
