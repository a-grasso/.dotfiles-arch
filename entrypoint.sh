#!/bin/bash

echo "---ENTRYPOINT---"

set -o errexit  # abort on nonzero exitstatus
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

readonly dotfiles='https://github.com/a-grasso/.dotfiles-arch'

# sudo is needed for dotfiles
if ! command -v sudo -p &>/dev/null; then
		pacman -Sy --noconfirm sudo > /dev/null
fi

sudo pacman -Sy > /dev/null

# git is needed for dotfiles
if ! command -v git -p &>/dev/null; then
		sudo pacman -S --noconfirm git > /dev/null
fi

# clone this very repo
git clone --quiet "${dotfiles}" repo > /dev/null
cd repo

clear

# setup everything
sudo chmod +x setup.sh
./setup.sh
