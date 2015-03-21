#! /usr/bin/env bash

# The script I use for gathering all the files for my dotfiles and minor projects github. Actually I could consider integrating "git add . -A" etc. right into this script. Worth considering.

# dotfiles/

dotfiles=upload/dotfiles/
home=/home/lys

cp /etc/bash.bashrc $dotfiles/
cp /etc/vimrc $dotfiles/
cp /etc/X11/xinit/xinitrc $dotfiles/
#cp $home/.bashrc $dotfiles    # I'm not really using it anyway.
cp $home/.Xresources $dotfiles/
cp $home/abs-aur/abs/dwm-6.0/dwm/src/dwm-6.0/config.h $dotfiles/dwm/
cp /usr/share/vim/vim74/colors/molokai_miyalys.vim $dotfiles/

#cp /home/lys/.pentadactylrc $dotfiles
cp $home/.gitconfig $dotfiles/

sed -i '/email/d' $dotfiles/.gitconfig

# irssi scripts list:
# using dir because my ls output is coloured by default, inserting weird meta characters in the file. The -1 part of dir means output one file per line.
# dir -R1 $home/.irssi/scripts | sed -e '/\//d' -e '/autorun/d' | tr ' ' '\n' | sort | uniq > $dotfiles/irssi_scripts.txt

# scripts/

scripts=upload/scripts/
sh=$home/sh

cp sync.sh $scripts
cp $sh/monoff.sh $scripts
cp $sh/monoffLock.sh $scripts
cp -r $sh/volume_controls $scripts
cp $sh/archive/xkcd_get/xkcd.sh $scripts
cp $sh/backups/conf_backup/conf_backup.sh $scripts
cp $sh/hibernate.sh $scripts
cp $sh/start_stop.sh $scripts
cp $sh/screenshot.sh $scripts

#web
#cp $home/www/lys/index.html upload/
#cp $home/www/lys/test.html upload/
#cp $home/www/lys/css.css upload/

# security
sed -i '/ssh/d' $dotfiles/bash.bashrc # -i means it will do the editing in place rather than output to stdout, avoiding some > workaround.

