

sudo pacman -S --needed --noconfirm base-devel git

if pacman -Qs yay > /dev/null ; then
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
fi

yay -S --noconfirm aconfmgr

aconfmgr apply
