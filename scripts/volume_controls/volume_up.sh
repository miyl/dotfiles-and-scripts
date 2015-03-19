#! /usr/bin/env bash

test=`amixer get Master | grep Mono: | awk '{print $6}' | sed -e 's/[^a-z]*//g' -e 's/off/0/g' -e 's/on/1/g' `

if [ $test -eq 0 ]; then
	amixer set Master unmute &>/dev/null

else
  amixer set Master 1+ &>/dev/null
fi
