#!/bin/bash

# Bitwarden session
#"$(echo $0)" -c "export BW_SESSION=$(bw login --raw)"

export BW_SESSION=$(bw {login,unlock} --raw)

echo $0
env
bw sync
