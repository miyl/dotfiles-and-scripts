#! /usr/bin/env bash
# -c 0 and -c 1 changed to use names instead, so they're always uniquely identifiable regardless of which number which card gets.

test=`amixer get Master | grep Mono: | awk '{print $4}' | sed -e 's/[^0-9]*//g'`

if [ $test -eq 0 ]; then
	amixer set Master mute 

else
  amixer set Master 1- 1>/dev/null
fi
