#! /usr/bin/env sh

# Worth looking into: https://github.com/wertarbyte/autorandr/blob/master/autorandr

# Possibly bind to FN+F3 like Windows. That currently calls up the scratchpad for some reason.

# Check if HDMI1 is connected/plugged in at all. Only done for the exit status. Returns 0 if found.
if xrandr | grep -q 'HDMI1 connected'; then


  # Check if the internal display is on. If yes turn it off and turn on HDMI1. Otherwise do the opposite.
  # This is done by extracting all the lines between a line containing eDP1 and HDMI1 with those two lines inclusive. 
  # why? To include all resolutions for eDP1 (which is listed first), but remove all resolutions for HDMI1, as they start right after the HDMI1 line, hereby excluded.
  # I then look for a "*" to indicate if eDP1 is enabled or not, and if it is turn it off and HDMI1 on - or vice versa. (actually * indicates current resolution which may be settable without enabling it, but still as long as I don't do that it should work?)
  # -n: quiet
  # / p: print the current pattern space

  if xrandr | sed -n -e '/eDP1/,/HDMI1/ p' | grep -q '*'; then
    xrandr --output HDMI1 --auto --output eDP1 --off 
  else
    xrandr --output eDP1 --auto --output HDMI1 --off 
  fi

# In case HDMI was disconnected before re-enabling eDP1 - leaving no displays on - this will enable it
else
    xrandr --output eDP1 --auto
fi
