#! /usr/bin/env sh

# Called the symlink to this mim instead of maim to not overwrite access to the regular maim program

DIR=$HOME/shots
# The current isodate with hours, minutes and seconds, to ensure a unique filename
FILENAME=$(date "+%Y-%m-%d-%H%M%S").png
PTH=$DIR/$FILENAME
PROG="maim"
#PROG="scrot"
#PROG="import -window root" # The -s argument below probably wouldn't work with this

success_msg() {
  msg "Screenshot saved to $FILENAME"
}

# TODO: Maybe one version of this should automatically upload it to imgur via imgur.sh? And maybe that should also be bound to a shortcut?

# It's \$ below because we NEED to expand DIR but also to NOT expand $f, as that's a parameter intended for the scrot command to deal with. So with \$ this script removes the \ and then scrot gets a literal $f
# An alternate idea for I solution I had would be to set $f2 = '$f' and then let it expand $f2 and then hopefully scrot would receive $f
if [ -z "$1" ]; then # Take screenshot of the full screen
  $PROG $PTH
  success_msg
elif [ "-s" = "$1" ];  then # Take screenshot of a region, passing no additional arguments
  if [ -z "$2" ]; then
    $PROG -s $PTH
    success_msg
  else
    $PROG -s $PTH
    imgur.sh $PTH 2>>$DIR/imgur_delete_paths.txt # For some reason if I $() this into a variable (in order to print it), it gets stuck, so not doing that
    msg "Screenshot uploaded and the URL is copied to clipboard."
    msg "Delete URL is $(tail -n 1 -z $DIR/imgur_delete_paths.txt)" # As per dunst defaults, middle click to open this url
  fi
else # If any arguments are passed besides -s, pass them all directly to maim, so this is just used to determine where the file is saved and what name it gets.
  $PROG $PTH "$@"
  success_msg
fi
