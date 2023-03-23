#!/bin/bash

echo "---CLOSEDOWN---"

function sudo_finish {
	echo "Restore permissions for sudo"
	sudo mv -f /etc/sudoers.bak /etc/sudoers
}
trap sudo_finish EXIT

############## zsh

chsh -s $(which zsh) "$(whoami)"

############## ssh

ssh-agent

eval $(ssh-agent)

ssh-add

############## lightdm

sudo systemctl enable lightdm
