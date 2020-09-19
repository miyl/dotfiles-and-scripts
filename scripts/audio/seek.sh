#! /usr/bin/env sh
# The script executes, but something goes wrong! VLC (the socket?) or the nc.openbsd command.
# pidof returns the pid if the process runs, otherwise nothing.

mplayer_seek="+5" # In seconds, relative seek by default
#deadbeef_seek="" # according to deadbeef -h it appears it has no option to seek :/
cmus_seek="--sek +5"

if [ "$1" = "b" ]; then
  # Overwrite to seek backwards
  mplayer_seek="-5" 
  deadbeef_seek=""
  cmus_seek="--seek -5"
fi

if [ "$(pidof cmus)" ]; then
  cmus-remote $cmus_seek
elif [ "$(pidof deadbeef)" ]; then
  deadbeef $deadbeef_seek
elif [ "$(pidof mplayer)" ]; then
  echo "seek $mplayer_seek" > /tmp/mplayercontrol
#elif [ "$(pidof vlc)" ]; then
  #echo -n "pause" | nc.openbsd -U $BIN_DIR/vlc.sock 2>/dev/null
  #echo -n "pause" | nc -U $BIN_DIR/vlc.sock 2>/dev/null
fi
