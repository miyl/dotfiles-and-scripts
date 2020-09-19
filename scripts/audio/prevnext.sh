#! /usr/bin/env bash
# The script executes, but something goes wrong! VLC (the socket?) or the nc.openbsd command.
# pidof returns the pid if the process runs, otherwise nothing.

deadbeef_prevnext="--next"
cmus_prevnext="--next"

if [ "$1" == "p" ]; then
  deadbeef_prevnext="--prev"
  cmus_prevnext="--prev"
fi

if [ "$(pidof cmus)" ]; then
  cmus-remote $cmus_prevnext
elif [ "$(pidof deadbeef)" ]; then
  deadbeef $deadbeef_prevnext
#elif [ "$(pidof vlc)" ]; then
  #echo -n "pause" | nc.openbsd -U $BIN_DIR/vlc.sock 2>/dev/null
#  echo -n "pause" | nc -U $BIN_DIR/vlc.sock 2>/dev/null
fi
