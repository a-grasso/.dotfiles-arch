FROM archlinux

RUN pacman -Syyu base-devel git sudo --noconfirm

RUN passwd -d root 

RUN useradd -d /home/anto -m -g users -G wheel -s /bin/bash anto

RUN passwd -d anto

RUN echo "anto ALL = NOPASSWD : ALL" >> /etc/sudoers
RUN echo "root ALL = NOPASSWD : ALL" >> /etc/sudoers

RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN echo 'root:asd' | chpasswd

RUN echo 'anto:asd' | chpasswd
