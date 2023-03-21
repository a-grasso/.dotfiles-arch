#!/bin/bash

readonly yellow='\e[0;33m'
readonly green='\e[0;32m'
readonly red='\e[0;31m'
readonly reset='\e[0m'

readonly dotfiles='https://github.com/a-grasso/.dotfiles-arch'

# Usage: log MESSAGE
#
# Prints all arguments on the standard output stream
log() {
	printf "${yellow}>> %s${reset}\n" "${*}"
}

# Usage: success MESSAGE
#
# Prints all arguments on the standard output stream
success() {
	printf "${green} %s${reset}}\n" "${*}"
}

# Usage: error MESSAGE
#
# Prints all arguments on the standard error stream
error() {
	printf "${red}!!! %s${reset}\n" "${*}" 1>&2
}

# Usage: die MESSAGE
# Prints the specified error message and exits with an error status
die() {
	error "${*}"
	exit 1
}

# Usage: yesno MESSAGE
#
# Asks the user to confirm via y/n syntax. Exits if answer is no.
yesno() {
	read -p "${*} [y/n] " -n 2 -r
	printf "\n"
	if [[ ! $REPLY =~ ^[Yy]$ ]]; then
		exit 1
	fi
}

# Usage: yesnoreturn MESSAGE
#
# Asks the user to confirm via y/n syntax. Returns answer and does not exit.
yesnoreturn() {
	read -p "${*} [y/n] " -n 2 -r
	printf "\n"
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		return 0
	fi
	return 1
}

# Usage: tryInstall NAME EXECUTABLE
#
# Asks the user permission to install NAME and then runs EXECUTABLE
tryInstall() {
	local name=${1}
	local executable=${2}

	log "It appears that ${name} is not installed and is required to continue."
	#yesno "Would you like to install it?"

	log "Installing ${name}..."
	${executable}
	success "${name} was successfully installed"
}

# Usage: checkDep NAME CONDITION EXECUTABE
#
# Checks CONDITION, if not true asks user to run EXECUTABLE
checkDep() {
	local name=${1}
	local condition=${2}
	local executable=${3}

	if ! ${condition} -p &>/dev/null; then
		tryInstall "${name}" "${executable}"
	else
		log "${name} detected, skipping install"
	fi
}

# Usage bwUnlock
#
# Attempts to login or unlock Bitwarden using the CLI
bwUnlock() {
	# Unlock -> login -> check if already unlocked -> die because unreachable
	if bw status | grep "locked" &>/dev/null; then
		export BW_SESSION="$(bw unlock --raw)"
	elif bw status | grep "unauthenticated" &>/dev/null; then
		export BW_SESSION="$(bw login --raw)"
	elif [[ -z "${BW_SESSION}" ]]; then
		die "Unknown bitwarden status"
	fi
	bw sync
}