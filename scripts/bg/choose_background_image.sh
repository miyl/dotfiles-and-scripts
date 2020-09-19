#! /usr/bin/env sh

DIR=$HOME/bgs/
PROGRAM="sxiv -tio"

# shell check recommended using find instead of ls
$SH_DIR/bg/set_bg.sh "$(fd --full-path $DIR | grep -v "info.txt\|ignored" | $PROGRAM )"

