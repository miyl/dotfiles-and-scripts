#!/usr/bin/env sh

# Cycles through all sources and sets whatever is the next one as the default.
# Pass -g to just print the current default source

TMP_SOURCES="$(pacmd list-sources | grep index)"
CUR_DEFAULT="$(echo "$TMP_SOURCES" | grep '*' | cut -d':' -f 2)"
SOURCES="$(echo "$TMP_SOURCES" | cut -d':' -f 2)"

[ -n "$1" ] && [ "$1" = "-g" ] && echo "$CUR_DEFAULT" && exit

FIRST_PASS=1
NEXT=0

for S in $SOURCES ; do
  # Store the first value for later, in case of the special case happening, where the current default is the last one.
  # AFAIK one can't always assume it's 0
  [ $FIRST_PASS -eq 1 ] && FIRST_SOURCE=$S && FIRST_PASS=0

  # If the loop doesn't end we reach this step, get the number of the next source and set it to default
  [ $NEXT -eq 1 ] && NEW_DEFAULT_SOURCE=$S && break

  # If the current value is the default, the next one should be the new one. Flag that - AFTER the check
  # Either The space before $S has to be there, or I need to trim it in CUR_DEFAULT, fx. with | xargs. I figure this is clearly better computationally
  [ " $S" = "$CUR_DEFAULT" ] && NEXT=1
done

[ -z "$NEW_DEFAULT_SOURCE" ] && NEW_DEFAULT_SOURCE=$FIRST_SOURCE

# Set default sink for new audio recordings
pacmd set-default-source "$NEW_DEFAULT_SOURCE"

notify-send "Switched default input source to index $NEW_DEFAULT_SOURCE"


# Switch all currently running audio streams over to the newly selected sink, via the script I found
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
$SCRIPT_DIR/pulse_in_source_switch_realtime.sh $NEW_DEFAULT_SOURCE
