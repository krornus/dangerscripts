#!/bin/bash

pacman -S i3 xorg xorg-xinit sakura firefox dmenu p7zip zsh

mkdir tmp
cd tmp

git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si
cd ..

cd ..
rm rf tmp

echo '[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx' > $HOME/.zprofile
echo 'exec i3' > $HOME/.xinitrc
