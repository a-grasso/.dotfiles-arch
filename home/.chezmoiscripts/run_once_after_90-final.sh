#!/bin/bash

echo "---FINAL---"

yesno() {
	read -p "${*} [y/n] " -n 2 -r
	printf "\n"
	if [[ ! $REPLY =~ ^[Yy]$ ]]; then
		exit 0
	fi
}

yesno "All Done - Do you want to reboot now?"

echo "rebooting..."

sleep 3

sudo reboot
