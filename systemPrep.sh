#!/bin/sh

printf "### Updating system..."
doas xbps-install -Syu
printf "### Install X..."
doas xbps-install -Sy xorg xorg-server xinit libX11-devel libXft-devel libXinerama-devel glib-devel font-inconsolata-otf
printf "### Install Building toolsxhkd sssssss..."
doas xbps-install -Sy git gcc make pkg-config curl bash-completion bash-devel
printf "### Install man pages..."
doas xbps-install -Sy man-pages-devel
printf "### Install tools for suckless surf..."
doas xbps-install -Sy webkit2gtk-devel gcr-devel
printf "### Install tools for suckless surf to play video..."
doas xbps-install -Sy gst-libav gst-plugins-good1
printf "### Install Multimedia..."
doas xbps-install -Sy mpd mpv ffmpeg yt-dlp
printf "### Install Diagnostics..."
doas xbps-install -Sy iotop htop lm_sensors
printf "### Install General tools..."
doas xbps-install -Sy groff sxhkd zathura-pdf-mupdf vim rsync firefox pulseaudio pulsemixer pamixer xz ImageMagick pass libreoffice python3-devel nnn ranger
printf "### Install e-Mail tools..."
doas xbps-install -Sy neomutt msmtp
printf "### Install FileSystems support..."
doas xbps-install -Sy fuse-exfat simple-mtpfs ntfs-3g
printf "### Install utilities"
doas xbps-install -Sy maim awk xclip xdotool nitrogen unzip patch mypaint moreutils w3m passmenu ueberzug skim rubber
printf "### Install vim plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
printf "### Install wheel and progressbar..."
doas xbps-install -Sy python3-pip
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
doas advcp -g /mnt/sdb1/mouad/ $HOME/ -r
doas chown mouad /home/mouad -R
doas chgrp mouad /home/mouad -R

for sucklessProgram in $(ls $HOME/src/suckless)
do
	cd $HOME/src/suckless/$sucklessProgram
	git checkout master
	doas make install
	make clean
done

curl -sL "https://raw.githubusercontent.com/pystardust/ytfzf/master/ytfzf" | doas tee /usr/local/bin/ytfzf >/dev/null && doas chmod 755 /usr/local/bin/ytfzf
