#! /usr/bin/env sh

# An alternative to this function would be storing this in a variable and using eval, but it's generally not considered safe

CHECK_FREQUENCY=475 # In seconds
SUSPEND_DELAY=6

while true; do

  FULL=$(cat /sys/class/power_supply/BAT1/energy_full)
  VOLTAGE=$(cat /sys/class/power_supply/BAT1/energy_now)
  STATUS=$(cat /sys/class/power_supply/BAT1/status)
  CHARGE=$((${VOLTAGE}*100/${FULL}))

  if  [ "$STATUS" = "Discharging" ]; then 
    if [ $CHARGE -lt 7 ]; then 
      msg "Battery very low: Suspending in $SUSPEND_DELAY seconds."
      sleep "$SUSPEND_DELAY"
      systemctl suspend &
    elif  [ $CHARGE -lt 12 ]; then msg "Battery low" -u critical
    fi
  fi
  sleep $CHECK_FREQUENCY

done
