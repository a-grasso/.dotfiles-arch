#!/bin/bash

set -o errexit  # abort on nonzero exitstatus
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

source ./common.sh

pacman -Sy

# sudo is needed for dotfiles
checkDep 'sudo' 'command -v sudo' 'pacman -S --noconfirm sudo'

# git is needed for dotfiles
checkDep 'git' 'command -v git' 'sudo pacman -S --noconfirm git'

# clone this very repo
git clone "${dotfiles}" repo
cd repo
sudo chmod +x setup.sh

# setup everything
./setup.sh
