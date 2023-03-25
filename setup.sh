#!/bin/bash

set -o errexit  # abort on nonzero exitstatus
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

source ./common.sh

gum style \
	--border double \
	--align center \
	"SETUP"


# need a scratch space for downloading files
#tmpDir="$(mktemp -d -t dev-setup-XXXXXXXXXX)"
#if [[ ! -d "${tmpDir}" ]]; then
#	die "Failed creating a temporary directory; cannot continue"
#fi

# sudo is needed for dotfiles
checkDep 'sudo' 'command -v sudo' 'pacman -S --noconfirm sudo'

# git is needed for dotfiles
checkDep 'git' 'command -v git' 'sudo pacman -S --noconfirm git'

# chezmoi is needed for dotfiles
checkDep 'chezmoi' 'command -v chezmoi' 'sudo pacman -S --noconfirm chezmoi'

# bitwarden-cli is needed to pull down secrets with chezmoi
checkDep 'bitwarden-cli' 'command -v bw' 'sudo pacman -S --noconfirm bitwarden-cli'

if yesnoreturn "Do you want to unlock bitwarden for chezmoi NOW?"; then
	# needs to be unlocked before calling chezmoi
	log "Logging into bitwarden..."
	bwUnlock
fi

if [[ ! -d "$HOME/.local/share/chezmoi" ]]; then
	log "Fetching dotfiles..."
	chezmoi init "${dotfiles}" > /dev/null
fi

log "Applying dotfiles..."
chezmoi apply > /dev/null
