#! /usr/bin/env sh

# This sleep can do floats, as I verified in the manual. The reason for the slight delay is that apparently in some cases when I executed it, I still hadn't left the keys with my fingers, so the screen would turn on again. Sort of similar to the reverse of having to press really fast to double click on a mouse?

sleep 0.2
xset dpms force off

[ "$1" = "lock" ] && slock
