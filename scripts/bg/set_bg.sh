#! /usr/bin/env bash 

# /home/$user/bin/astronomy_potd_wallpaper.sh

# feh: 438.64 KiB installed - xwallpaper: 43.87 KiB installed

# bg-center: centers the image, and if it's too large it will be cropped in both dimensions
# bg-fill: if too large it scales it down till the first dimension fits, and then it might crop in the second one
# bg-max: Scales it down till the largest dimension fits, and then it fills the space left empty from the smaller dimension with some background color you can specify
# --no-fehbg: don't create a ~/.fehbg file. Not sure what it's used for anyway?
#CMD="feh --bg-fill --no-fehbg"
# -zoom: basically seems to do the same as feh's bg-fill:
CMD="xwallpaper --zoom"

# Simply put "r" into this file to randomize, no longer a need to change xinitrc when switching between random and a specific one, and choose-background overwrites this and becomes permanent instead of session only (if it was set in xinitrc)!
CONF="$SH_DIR/bg/current_background_image.conf"

if [ -n "$1" ]; then
 echo "$1" > $CONF
fi

VAR=$(cat $CONF)

if [ "$VAR" = "r" ]; then
  DIR=$HOME/bgs/
  $CMD "$(shuf -n 1 <(fd . -a --full-path $DIR | grep -ve "info.txt\|ignored"))"
else
  $CMD "$VAR"
fi
