#!/bin/bash

# bitwarden cli & ssh key prep
echo "ssh prep"

sudo pacman -S --noconfirm bitwarden-cli

bw login
# -> email
# -> master password

export BW_SESSION=$(bw unlock --raw)

bw sync

mkdir ~/.ssh
sudo chmod 0700 ~/.ssh

bw get notes pub > ~/.ssh/id_rsa.pub
bw get notes sshkey > ~/.ssh/id_rsa
sudo chmod 0600 ~/.ssh/id_rsa

# ssh
echo "ssh"
ssh-agent

eval $(ssh-agent)

ssh-add

# dotfiles setup
echo "dotfiles"

sudo pacman -S --noconfirm git

mkdir $HOME/.dotfiles

git init --bare $HOME/.dotfiles

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

dotfiles config --local status.showUntrackedFiles no

dotfiles remote add origin git@github.com:a-grasso/.dotfiles-arch.git

# zsh & oh-my-zsh
echo "zsh"

sudo pacman -S --noconfirm zsh

chsh -s $(which zsh)

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# theme
echo "theme"
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# apply config
echo "applying dotfiles configs"
dotfiles fetch --all
dotfiles reset --hard origin/master


echo "DONE"
