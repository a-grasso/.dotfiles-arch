#!/bin/bash

clear

echo "---All DONE---"

yesno() {
	read -p "${*} [y/n] " -n 2 -r
	printf "\n"
	if [[ ! $REPLY =~ ^[Yy]$ ]]; then
		exit 0
	fi
}

yesno "Do you want to reboot now?"

echo "rebooting..."

sleep 3

sudo reboot
