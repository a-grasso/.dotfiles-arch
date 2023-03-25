#!/bin/bash

gum style \
	--border double \
	--align center \
	"CLOSEDOWN"

############## zsh

chsh -s $(which zsh) "$(whoami)"

############## ssh

ssh-agent

eval $(ssh-agent)

ssh-add

############## lightdm

#sudo -u "$(whoami)" -n bash -c "sudo systemctl enable lightdm"
#sudo systemctl enable lightdm
sudo systemctl enable sddm
