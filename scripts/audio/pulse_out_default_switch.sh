#! /usr/bin/env sh

# Sinks can be specified by name or index. Index changes sometimes when you disconnect and reconnect, restart or whatever, so names are better.
# Annoyingly the command used to switch audio over to a new sink cannot take a name as its argument, otherwise I'd only need the name here.

# TODO: Trigger a zenity or dmenu dialog with entr that asks whether to switch monitor and/or sound to hdmi? Could do
# the same for mounting.

# Names, which unlike indexes are persistent
PCM=DeviceNameHere
HDMI=DeviceNameHere

# Getting the indexes dynamically. grepping on the name and then including the previous line which has the index, and then getting the number from there.
PCM_INDEX=$(pacmd list-sinks | grep -B 1 $PCM | head -n 1 | cut -d':' -f 2)
HDMI_INDEX=$(pacmd list-sinks | grep -B 1 $HDMI | head -n 1 | cut -d':' -f 2)

# TODO: Make this script not try to switch audio output when HDMI isn't even plugged in, ie. when $HDMI is an empty-ish string.
#if pacmd list-sinks | grep -q "* index: $PCM"; then
if pactl info | grep -q "Sink: $PCM"; then
  NEW_DEFAULT_SINK=$HDMI_INDEX
else 
  NEW_DEFAULT_SINK=$PCM_INDEX
fi

# There's also move-source-output, but unfortunately it works only on index and not on name.
# The advantage of this method is one doesn't have to stop and start audio currently playing, to get it to play back on the new source
#From pacmd --help: pacmd move-(sink-input|source-output) #N SINK|SOURCE
#pacmd move-source-output $TO $FROM

# Set default sink for new audio playback
pacmd set-default-sink $NEW_DEFAULT_SINK

notify-send "Switched default output sink to index $NEW_DEFAULT_SINK"


# Switch all currently running audio streams over to the newly selected sink, via the script I found
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
$SCRIPT_DIR/pulse_out_sink_switch_realtime.sh $NEW_DEFAULT_SINK
