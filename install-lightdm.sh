sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings lightdm-slick-greeter

sudo systemctl enable lightdm.service -f

sudo reboot
