#! /usr/bin/env bash

test=`amixer -c Intel get Master | grep Mono: | awk '{print $6}' | sed -e 's/[^a-z]*//g' -e 's/off/0/g' -e 's/on/1/g' `

if [ $test -eq 0 ]; then
	amixer -c Intel set Master unmute &>/dev/null

else
amixer -c Intel set Master 1+ &>/dev/null
amixer -c TonePortUX2 set PCM 7+ &>/dev/null

fi
