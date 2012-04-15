#! /usr/bin/env bash
# A small script I modified from another script I made to enable and disable the taskbar in awesome, reconfigured to replace the .asoundrc with another file, in which the internal sound card is the default, rather than toneport (my external sound card).

# This shortcut is in dwm's config: WIN + CTRL + 0 (zero) 
# After this the new config should be functional as soon as the application has been restarted if already started.
# Repeat the process to change it back and forth.

cp ~/.asoundrc ~/.asoundrc_bak
mv ~/.asoundrc_replacement ~/.asoundrc
mv ~/.asoundrc_bak ~/.asoundrc_replacement
amixer -c Intel set Master 50% &>/dev/null
amixer -c TonePortUX2 set PCM 50% &>/dev/null
