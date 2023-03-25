#!/bin/bash

set -o errexit  # abort on nonzero exitstatus
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

readonly dotfiles='https://github.com/a-grasso/.dotfiles-arch'

# sudo is needed for dotfiles
if ! command -v sudo -p &>/dev/null; then
		pacman -Sy --noconfirm sudo &> /dev/null
fi

sudo pacman -Sy --noconfirm --needed sudo git gum &> /dev/null

gum style \
	--border double \
	--align center \
	"ENTRYPOINT"

# scratch work directory
tmpDir="$(mktemp -d -t entrypoint-XXXX)"
trap "sudo rm -rf ${tmpDir}" EXIT

# clone this very repo
git clone --quiet "${dotfiles}" "${tmpDir}"
cd "${tmpDir}"

# setup everything
sudo chmod +x setup.sh
./setup.sh
