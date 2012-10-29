#! /usr/bin/env bash
# The script executes, but something goes wrong! VLC (the socket?) or the nc.openbsd command.

if [ "$(pidof cmus)" ]
then
# cmus:
cmus-remote -u
else
# VLC:
echo -n "pause" | nc.openbsd -U /home/lys/bin/vlc.sock 2>/dev/null
fi
