#!/bin/bash

clear

echo "---INSTALL---"

#sudo pacman -Sy
#sudo pacman -Sy --noconfirm archlinux-keyring
#sudo pacman -Syyu --noconfirm

PACKAGES=""
AURPACKAGES=""

PACKAGES+="git

zsh

bitwarden-cli
xorg
lightdm
lightdm-gtk-greeter
lightdm-gtk-greeter-settings
lightdm-slick-greeter

bspwm
sxhkd
"
#nitrogen
#feh
#polybar
#dmenu
#thunar
#picom
#rofi
#
#chezmoi
#
#papirus-icon-theme
#
#dunst





# PACKAGES+="
# networkmanager
# base-devel
# xorg
# xorg-apps
# xf86-input-libinput
# xf86-video-intel
# xorg-fonts
# wayland
# clipmenu
# xss-lock
# xautolock
# "

su root -c "echo \"Installing packages...\" && \
pacman -Syu --noconfirm && \
pacman -Sy $(echo $PACKAGES | tr -s '\n' ' ') --needed --noconfirm && \
echo \"Create temporary permissions for sudo...\" && \
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

if ! [ -x "/usr/bin/yay" ]; then
	echo "Installing yay..."
	pushd /tmp/
		sudo -u "$(whoami)" mkdir -p "/tmp/yay-install/"
		pushd yay-install
			sudo -u "$(whoami)" -n bash -c "curl https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=yay > PKGBUILD"
			sudo -u nobody -n makepkg -sicf --needed --noconfirm
		popd

		sudo -u "$(whoami)" -n bash -c "rm -rf yay-install"
	popd
fi

echo "Installing AUR packages..."
sudo -u "$(whoami)" yay -S $(echo $AURPACKAGES | tr -s '\n' ' ') --needed --noconfirm

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# ZSH powerlevel10k theme
ZSH_PL10K_THEME_DIR="/home/$(whoami)/.oh-my-zsh/custom/themes/powerlevel10k"
if [ -d "$ZSH_PL10K_THEME_DIR" ]; then
        # Updating
        echo "Updating zsh powerlevel10k theme..."
        pushd "$ZSH_PL10K_THEME_DIR"
              git pull
        popd
else
        # Installing
        echo "Installing zsh powerlevel10k theme..."
        git clone https://github.com/romkatv/powerlevel10k.git "$ZSH_PL10K_THEME_DIR"
fi
