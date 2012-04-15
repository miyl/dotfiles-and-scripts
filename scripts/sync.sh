#! /usr/bin/env bash

# The script I use for gathering all the files for my dotfiles and minor projects github. Actually I could consider integrating "git add . -A" etc. right into this script. Worth considering.

# dotfiles/

dotfiles=upload/dotfiles/
home=/home/lys

cp /etc/bash.bashrc $dotfiles
cp /etc/vimrc $dotfiles
cp /etc/X11/xinit/xinitrc $dotfiles
cp $home/.bashrc $dotfiles
cp $home/.Xresources $dotfiles
cp $home/bin/inst/dwm/config.h $dotfiles/dwm/
#cp /home/lys/.pentadactylrc $dotfiles

# scripts/

scripts=upload/scripts/
sh=$home/sh

cp sync.sh $scripts
cp $sh/asoundrc_xchange.sh $scripts
cp $sh/monoff.sh $scripts
cp $sh/monoffLock.sh $scripts
cp -r $sh/volume_controls $scripts
cp $sh/xkcd_get/xkcd.sh $scripts
cp $sh/backups/conf_backup/conf_backup.sh $scripts
cp $sh/hibernate.sh $scripts
