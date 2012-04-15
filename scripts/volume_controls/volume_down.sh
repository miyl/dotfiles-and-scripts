#! /usr/bin/env bash
# -c 0 and -c 1 changed to use names instead, so they're always uniquely identifiable regardless of which number which card gets.

test=`amixer -c Intel get Master | grep Mono: | awk '{print $4}' | sed -e 's/[^0-9]*//g'`

amixer -c TonePortUX2 set PCM 7- &>/dev/null 
if [ $test -eq 0 ]; then
	amixer -c Intel set Master mute 

else
amixer -c Intel set Master 1- 1>/dev/null
fi
