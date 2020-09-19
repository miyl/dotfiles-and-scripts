#! /usr/bin/env sh

# The basic idea of this script is to automatically run the wless script with the proper settings if the wireless
# ethernet card is connected via USB and it's not currently connected to a network. "With its proper settings" means it
# needs to do a scan of wireless networks  and on the basis of the SSID run wless with the correct parameter, and set
# the relevant static IP

SSIDS="wifi1|wifi2" # I realized it's irrelevant to check for say eduroam, since so many use dhcp anyway, so it might as well be default.
DEVICE="wlp1s0"

# The device needs to be up before we can scan. Do that and wait a while for it to initialize so the chance of finding the SSIDs is higher?
ip link set $DEVICE up
sleep 0.75 # I was thinking maybe the device isn't even initialized yet and the scan fails, and no static IPs are used?

DEV_CONNECTED=$(ip link show $DEVICE) # Check if the wireless device is inserted / exists. This made sense to check when I used a USB wireless card - maybe not now?
STATUS=$(/usr/sbin/iw dev $DEVICE link) # Check if it is connected to a wireless network.
if [ "$DEV_CONNECTED" != "" ] || [ "$STATUS" = "Not connected." ]; then
  # -P is perl regex mode, cut isolates the value of ssid, tr removes extraneous spaces, head removes doubles of SSID's when there's wireless repeaters. 
  # That also means it defaults to whatever is first, which I guess incidentally might be the network with the highest signal strength.
  SSID=$(/usr/sbin/iw $DEVICE scan | grep -P "$SSIDS" | cut -d ':' -f 2 | tr -d ' ' | head -n 1)
  case $SSID in
    wifi1)  # tr removes the spaces currently, so...
      $SH_DIR/net.sh -q w 1;;
    wifi2)
      $SH_DIR/net.sh -q w 2;;
    *) # calls dhcpcd
      $SH_DIR/net.sh -q w;;
  esac
fi
