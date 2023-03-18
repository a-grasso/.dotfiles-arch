#!/bin/bash

sudo pacman -Sy
sudo pacman -Sy --noconfirm archlinux-keyring
sudo pacman -Syyu --noconfirm

############################################################
# git
echo "-----> git"

sudo pacman -S --noconfirm git
############################################################
# zsh & oh-my-zsh
echo "-----> zsh & oh-my-zsh"

sudo pacman -S --noconfirm zsh

chsh -s $(which zsh)

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
############################################################
# theme
echo "-----> theme"
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k # $ZSH_CUSTOM would need a change into zsh shell
############################################################
# bitwarden cli
echo "-----> bitwarden cli"

sudo pacman -S --noconfirm bitwarden-cli

export BW_SESSION=$(bw login --raw)
# -> input email
# -> input master password

bw sync
############################################################
# lightdm
sudo pacman -S --noconfirm xorg lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings lightdm-slick-greeter

sudo systemctl enable lightdm
############################################################
# packages
sudo pacman -S --noconfirm bspwm sxhkd nitrogen feh polybar dmenu alacritty thunar picom rofi
############################################################
# apply config
echo "-----> chezmoi & applying dotfiles"

sudo pacman -S --noconfirm chezmoi

chezmoi init --apply --verbose https://github.com/a-grasso/.dotfiles-arch.git

#mkdir ~/.ssh
#sudo chmod 0700 ~/.ssh

#bw get notes pub > ~/.ssh/id_rsa.pub
#bw get notes sshkey > ~/.ssh/id_rsa
#sudo chmod 0600 ~/.ssh/id_rsa
############################################################
# ssh
echo "-----> ssh"
ssh-agent

eval $(ssh-agent)

ssh-add
############################################################
# aconfmgr
#echo "-----> aconfmgr"
#if pacman -Qs yay > /dev/null ; then
#  echo "!!!yay ALREADY installed!!!"
#  else
#  echo "!!!yay NOT installed!!!"
#  git clone https://aur.archlinux.org/yay.git
#  cd yay
#  makepkg -si 
#fi
#
#yay -S --noconfirm aconfmgr
#
#aconfmgr apply
############################################################
echo "DONE"
############################################################
echo "******MANUAL TODOs******"
echo ">>>>> lightdm greeter switch to slick"
