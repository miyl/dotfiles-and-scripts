#! /usr/bin/env sh

# The idea is this could be printed to the status line (xmobar, i3status or whatever)

SRC=$(pactl info | grep "Default Source" | cut -d':' -f 2)
SINK=$(pactl info | grep "Default Sink" | cut -d':' -f 2)

case $SRC in
  " alsa_input.pci-0000_00_1b.0.analog-stereo")
    SRC_IS="Internal"
    ;;
  " alsa_input.usb-Roland_UA-22-00.analog-stereo")
    SRC_IS="Duo Capture"
    ;;
  *)
    SRC_IS="Unknown"
    ;;
esac

case $SINK in
  " alsa_output.pci-0000_00_1b.0.analog-stereo")
    SINK_IS="Internal"
    ;;
  "")
    SINK_IS="Duo Capture??"
    ;;
  *)
    SINK_IS="Unknown"
    ;;
esac

echo "In: $SRC_IS - Out: $SINK_IS"
