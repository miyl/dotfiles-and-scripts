#!/usr/bin/env sh

# Recursively searches the current directory for all images, and opens them all with sxiv. Unlike gwenview it seems sxiv doesn't represent subdirectories in thumbnail mode, so this is especially relevant

[ -z $1 ] && PTH="." || PTH="$1"

fd --type f '.jpg|.png|.gif|.jpeg' $PTH | sxiv -ifbt
