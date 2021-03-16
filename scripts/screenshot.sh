#! /usr/bin/env sh

SCREENSHOT_DIR=$HOME/shots
# The current isodate with hours, minutes and seconds, to ensure a unique filename
FILENAME=$(date "+%Y-%m-%d-%H%M%S").png
PTH=$SCREENSHOT_DIR/$FILENAME
PROG="maim"
#PROG="scrot"
#PROG="import -window root" # The -s argument below probably wouldn't work with this

help() {
  printf '%s\n' 'Screenshot program wrapper, pre-setting path and name' \
                'Prerequisites: imgur.sh for the automatic imgur uploading option' \
                '-s    - Select region' \
                '-s -i - Select region, upload to imgur' \
                '-f    - Fullscreen screenshot' \
                "-p    - Pass arguments directly to $PROG"
}

success_msg() {
  msg "Screenshot saved to $FILENAME"
}

if [ -z "$1" ]; then
  help
elif [ "-f" = "$1" ]; then # Take screenshot of the full screen
  $PROG "$PTH" && success_msg
elif [ "-s" = "$1" ];  then # Take screenshot of a region, passing no additional arguments
  if [ -z "$2" ]; then
    $PROG -s "$PTH" && success_msg
  elif [ "-i" = "$2" ]; then
    $PROG -s "$PTH"
    imgur.sh "$PTH" 2>>"$SCREENSHOT_DIR/imgur_delete_paths.txt" # For some reason if I $() this into a variable (in order to print it), it gets stuck, so not doing that
    msg 'Screenshot uploaded and the URL is copied to clipboard.'
    msg "Delete URL is "$(tail -n 1 -z $SCREENSHOT_DIR/imgur_delete_paths.txt)"" # As per dunst defaults, middle click to open this url
  else 
    help
  fi
elif [ "-p" = "$1" ]; then # Pass them all directly to the program, so this is just used to determine the file path
  $PROG "$PTH" "$@" && success_msg
else 
  help
fi
