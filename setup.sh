#!/bin/bash

set -o errexit  # abort on nonzero exitstatus
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

source ./common.sh

gum style \
	--border double \
	--align center \
	"SETUP"

# sudo is needed for dotfiles
checkDep 'sudo' 'command -v sudo' 'pacman -S --noconfirm sudo'

# git is needed for dotfiles
checkDep 'git' 'command -v git' 'sudo pacman -S --noconfirm git'

# chezmoi is needed for dotfiles
checkDep 'chezmoi' 'command -v chezmoi' 'pacboi chezmoi'

# bitwarden-cli is needed to pull down secrets with chezmoi
checkDep 'bitwarden-cli' 'command -v bw' 'sudo pacman -S --noconfirm bitwarden-cli'

gum confirm "Do you want to unlock bitwarden for chezmoi NOW?" && bwUnlock

if [[ ! -d "$HOME/.local/share/chezmoi" ]]; then
	log "Fetching dotfiles..."
	chezmoi init "${dotfiles}" > /dev/null
fi

log "Applying dotfiles..."
chezmoi apply
