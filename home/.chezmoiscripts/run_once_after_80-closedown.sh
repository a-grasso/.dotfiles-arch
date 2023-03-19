#!/bin/bash

clear

echo "---CLOSEDOWN---

su root -c "echo \"Create temporary permissions for sudo...\" && \
mv -f /etc/sudoers /etc/sudoers.bak && \
echo \"root ALL=(ALL) ALL\" > /etc/sudoers && \
echo \"$(whoami) ALL = NOPASSWD : ALL\" >> /etc/sudoers && \
echo \"%wheel ALL=(ALL) NOPASSWD: ALL\" >> /etc/sudoers
"

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
sudo -u "$(whoami)" -n bash -c "sudo systemctl enable lightdm"
