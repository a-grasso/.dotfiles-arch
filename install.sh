
# bitwarden cli
pacman -S --noconfirm bitwarden-cli

## ssh key prep
bw login
# -> email
# -> master password

bw sync

mkdir ~/.ssh
chmod 0700 ~/.ssh

bw notes get pub > ~/.ssh/id_rsa.pub
bw notes get sshkey > ~/.ssh/id_rsa
chmod 0600 ~/.ssh/id_rsa

ssh-agent

eval $(ssh-agent)

ssh-add

# dotfiles setup

pacman -S --noconfirm git

mkdir $HOME/.dotfiles

git init --bare $HOME/.dotfiles

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

dotfiles config --local status.showUntrackedFiles no

dotfiles remote add origin git@github.com:a-grasso/.dotfiles-arch.git

# zsh & oh-my-zsh

pacman -S --noconfirm zsh

chsh -s $(which zsh)

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# theme

git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
