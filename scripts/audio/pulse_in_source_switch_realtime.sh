#!/usr/bin/env sh

# SRC for this script: 
# https://askubuntu.com/questions/71863/how-to-change-pulseaudio-sink-with-pacmd-set-default-sink-during-playback
# Rewritten to deal with sources/inputs instead

# There's also move-source-output, but unfortunately it works only on index and not on name.
# The advantage of this method is one doesn't have to stop and start audio currently playing, to get it to play back on the new source
# From pacmd --help: pacmd move-(sink-input|source-output) #N SINK|SOURCE

case "${1:-}" in
  (""|list)
    pacmd list-sources |
      grep -E 'index:|name:'
    ;;
  ([0-9]*)
    echo "switching default to index $1"
    pacmd set-default-source $1 ||
      echo failed
    echo switching applications
    pacmd list-source-outputs |
      awk '/index:/{print $2}' |
      xargs -r -I{} pacmd move-source-output {} $1 ||
        echo failed
    ;;
  (*)
    echo "Usage: $0 [|list|<source name to switch to>]"
    ;;
esac
