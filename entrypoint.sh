#!/bin/bash

set -o errexit  # abort on nonzero exitstatus
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

readonly dotfiles='https://github.com/a-grasso/.dotfiles-arch'

# sudo is needed for dotfiles
local condition='command -v sudo'
local executable='pacman -Sy --noconfirm sudo'
if ! ${condition} -p &>/dev/null; then
		${executable}
fi

sudo pacman -Sy

# git is needed for dotfiles
condition='command -v git'
executable='sudo pacman -S --noconfirm git'
if ! ${condition} -p &>/dev/null; then
		${executable}
fi

# clone this very repo
git clone "${dotfiles}" repo
cd repo
sudo chmod +x setup.sh

# setup everything
./setup.sh
