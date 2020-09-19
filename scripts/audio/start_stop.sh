#! /usr/bin/env sh
# The script executes, but something goes wrong! VLC (the socket?) or the nc.openbsd command.
# pidof returns the pid if the process runs, otherwise nothing.

if [ "$(pidof cmus)" ]; then
  cmus-remote -u
elif [ "$(pidof deadbeef)" ]; then
  deadbeef --play-pause
elif [ "$(pidof mplayer)" ]; then
  # See commands here: http://www.mplayerhq.hu/DOCS/tech/slave.txt
  echo 'pause' > /tmp/mplayercontrol
elif [ "$(pidof vlc)" ]; then
  #echo -n "pause" | nc.openbsd -U $BIN_DIR/vlc.sock 2>/dev/null
  # TODO: Might not work with sh currently as echo -n is not supported, unlike bash as it was before?
  echo -n "pause" | nc -U $BIN_DIR/vlc.sock 2>/dev/null
fi
