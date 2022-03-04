#!/bin/sh

printf "### Updating system..."
doas pacman -Syu --noconfirm
printf "### Install X..."
doas pacman -S --noconfirm  xorg xorg-server xorg-xinit libx11 libxft libxinerama glib2
printf "### Install Building toolsxhkd sssssss..."
doas pacman -S --noconfirm  git gcc make pkg-config curl bash-completion wget
printf "### Install man pages..."
doas pacman -S --noconfirm  man-pages
printf "### Install tools for suckless surf..."
doas pacman -S --noconfirm  webkit2gtk gcr
printf "### Install tools for suckless surf to play video..."
doas pacman -S --noconfirm  gst-libav gst-plugins-good
printf "### Install Multimedia..."
doas pacman -S --noconfirm  mpd mpv ffmpeg yt-dlp
printf "### Install Diagnostics..."
doas pacman -S --noconfirm  iotop htop lm_sensors
printf "### Install General tools..."
doas pacman -S --noconfirm  groff sxhkd zathura-pdf-mupdf vim rsync pipewire pipewire-pulse pulsemixer pamixer xz imagemagick pass libreoffice-fresh python3 nnn ranger
printf "### Install e-Mail tools..."
doas pacman -S --noconfirm  neomutt msmtp
printf "### Install FileSystems support..."
doas pacman -S --noconfirm  exfat-utils mtpfs
printf "### Install utilities"
doas pacman -S --noconfirm  maim awk xclip xdotool nitrogen unzip patch mypaint moreutils w3m ueberzug skim rubber exa espeak-ng
printf "### Install vim plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
printf "### Install wheel and progressbar..."
doas pacman -S --noconfirm python-pip
pip install wheel
pip install progressbar
pip install manim

wget http://ftp.gnu.org/gnu/coreutils/coreutils-9.0.tar.xz
tar xvJf coreutils-9.0.tar.xz
cd coreutils-9.0/
wget https://raw.githubusercontent.com/jarun/advcpmv/master/advcpmv-0.9-9.0.patch
patch -p1 -i advcpmv-0.9-9.0.patch
./configure
make

doas cp ./src/cp /usr/local/bin/cpg
doas cp ./src/mv /usr/local/bin/mvg
doas mv ./src/cp /usr/local/bin/advcp
doas mv ./src/mv /usr/local/bin/advmv
rm -rf $HOME/coreutils*
doas advcp -g /mnt/sdb1/* $HOME/ -r
doas chown mouad /home/mouad -R
doas chgrp mouad /home/mouad -R

for sucklessProgram in $(ls $HOME/src/suckless)
do
	cd $HOME/src/suckless/$sucklessProgram
	git checkout master
	doas make -j 4 install
	make clean
done

curl -sL "https://raw.githubusercontent.com/pystardust/ytfzf/master/ytfzf" | doas tee /usr/local/bin/ytfzf >/dev/null && doas chmod 755 /usr/local/bin/ytfzf
