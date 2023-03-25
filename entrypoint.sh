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

# gum is needed for further scripting
if ! command -v gum -p &>/dev/null; then
		sudo pacman -S --noconfirm gum
fi

# need a scratch space for downloading files
tmpDir="$(mktemp -d -t dotfiles-repo-XXXXXXXXXX)"
if [[ ! -d "${tmpDir}" ]]; then
	printf "${red}!!! %s${reset}\n" "Failed creating a temporary directory; cannot continue" 1>&2
	exit 1
fi
function cleanup {
	echo "Cleaning up entrypoint"
	sudo rm -rf ${tmpDir}
}
trap cleanup EXIT

# clone this very repo
git clone --quiet "${dotfiles}" "${tmpDir}" > /dev/null
cd "${tmpDir}"

# setup everything
sudo chmod +x setup.sh
./setup.sh
