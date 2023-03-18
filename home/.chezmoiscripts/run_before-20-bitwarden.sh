#!/bin/bash

# Bitwarden session
sudo -u "$(whoami)" zsh -c "export BW_SESSION=$(bw login --raw)"
sudo -u "$(whoami)" sh -c "export BW_SESSION=$(bw login --raw)"
sudo -u "$(whoami)" bash -c "export BW_SESSION=$(bw login --raw)"

bw sync
