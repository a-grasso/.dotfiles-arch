#!/bin/bash

# bitwarden cli & ssh key prep
echo "ssh prep"

sudo pacman -S --noconfirm bitwarden-cli

export BW_SESSION=$(bw login --raw)
# -> email
# -> master password

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

#mkdir $HOME/.dotfiles
#git init --bare $HOME/.dotfiles
#alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
#dotfiles config --local status.showUntrackedFiles no
#dotfiles remote add origin git@github.com:a-grasso/.dotfiles-arch.git

# zsh & oh-my-zsh
echo "zsh"

sudo pacman -S --noconfirm zsh

chsh -s $(which zsh)

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# theme
echo "theme"
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k # $ZSH_CUSTOM needs a change into zsh shell

# apply config
echo "applying dotfiles configs"

git clone --separate-git-dir=$HOME/.dotfiles https://github.com/a-grasso/.dotfiles-arch.git tmpdotfiles
rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
rm -r tmpdotfiles

echo "DONE"

sleep 5
sudo reboot
