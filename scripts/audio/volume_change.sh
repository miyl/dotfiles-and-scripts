#! /usr/bin/env sh
# -c 0 and -c 1 changed to use names instead, so they're always uniquely identifiable regardless of which number which card gets.

EXIT_STATUS_HDMI_DEFAULT=0

# Which device is default?
# -q: quiet, -c count matching lines, -v search for non matching
RES=$(amixer info default)
HDMI=$(printf %s $RES | grep 'HDMI') # If HDMI is found the exit status of grep is 0, AKA true
PCH=$(printf %s $RES | grep 'PCH')
PULSE=$(printf %s $RES grep 'pulse')

# Pulseaudio's scale is apparently very huge compared to PCH, so a volume change of 400 amounts to around 1% or less!
if [ "$PULSE" ]; then AMOUNT=700
elif [ "$HDMI" ]; then AMOUNT=2
else AMOUNT=1; 
fi

if [ "$1" = "-inc" ]; then DIRECTION='+'; MUTE='unmute'
else DIRECTION='-'; MUTE='mute'
fi

if [ "$HDMI" ]; then 
  CONTROL="PCM"

  # TODO: Can HDMI be muted/unmuted?
  amixer -q set $CONTROL $AMOUNT$DIRECTION

# Working for both ALSA default and Pulseaudio
else 
  CONTROL='Master'

  # Retrieves on/off state: If muted -> unmute. Can't grep on "on" as its part of "Mono", but I think off might be unique?
  #if [ amixer get $CONTROL | grep $CHANNEL: | awk '{print $6}' | sed -e 's/[^a-z]*//g' -e 's/off/0/g' -e 's/on/1/g' ]; then
  #if [`amixer get $CONTROL | grep Mono: | awk '{print $4}' | sed -e 's/[^0-9]*//g'`]
  if [ $(amixer get $CONTROL | grep 'off') ]; then
    amixer -q set $CONTROL $MUTE

  else
    amixer -q set $CONTROL $AMOUNT$DIRECTION
  fi

fi
