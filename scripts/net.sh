#! /usr/bin/env sh

# CONFIG

lan="enp1s0"
wlan="wlp1s0"
wpasupconfpath="$DOTFILES_DIR/wpa_supplicant.conf"

# HELPERS

help() {
  printf '%s\n' "Unfinished script! Only arguments 1-3 work." \
          "net.sh takes four positional arguments of which only the 1st is required." \
          "1: Specifies interface: w for WLAN or l for LAN." \
          "2: Specifies either a default IP (h, f, b, a), dhcp or command line specified IP or -d to down the interface and exit. No second argument means DHCP" \
          "3: Specifies (default) gateway. Only needed when the second argument is an IP." \
          "NOT IMPLEMENTED!: The 4th is for wireless. Specifies either wpa_supplicant.conf or a command line specified SSID" \
          "NOT IMPLEMENTED!: The 5th is for wireless. specifies a psk for secured wireless networks. If not given it tries to connect to it without a passphrase/psk"
  exit
}

# Takes an interface to down
net_down() {

  if [ "$1" = $wlan ]; then
    rfkill block wifi
    echo "Disabling WLAN"
  else
    echo "Disabling LAN"
  fi

  ip addr flush dev "$1"
  ip route flush dev "$1"
  ip link set "$1" down
}


# MAIN PROGRAM

[ -z "$1" ] || [ "$1" = "--help" ] || [ "$1" = "-h" ] && help

# Default is verbose and foreground, for debugging. Pass -q to suppress that output and background it
# NOTE: If not passed it never gets to the DHCP step as wpa_supplicant remains occupied in the foreground
if [ "$1" = "-q" ]; then
  background="-B"
  shift
fi

# Run this no matter what, to down it, pending restart or not
killall -q wpa_supplicant
killall -q -s SIGKILL dhcpcd # Default is SIGTERM but it seems it often isn't enough.


if [ "$1" = "w" ]; then
  devdown=$lan
  devup=$wlan
  rfkillunblockmaybe="rfkill unblock wifi" # This HAS to be before ip link set up, otherwise that fails. On the other hand it's unnecessary if wifi is being downed by net_down right after?
elif [ "$1" = "l" ]; then
  devdown=$wlan
  devup=$lan
else
  echo "Second argument should be w for WLAN of l for LAN)"
fi

# Handling this first so rfkill unblock wifi isn't run.
# Update: But it HAS to run after to pass in the interface name
if [ "$2" = "-d" ]; then 
  net_down $devup "$2"
  exit
fi

# Setting up:
net_down $devdown               # Downs the other interface
sleep 2

# Cleanup + upping the desired interface
ip addr flush dev $devup
ip route flush dev $devup
$rfkillunblockmaybe
ip link set $devup up

if [ $devup = $wlan ]; then
  echo "Running for WLAN - disabling LAN" # Putting these here so they aren't printed when -d is passed
  # Set the network to adhoc. It may not be though, so worth trying to disable:
  #iw $wlan set type ibss

  # Use the nl80211 driver (maybe it's default as of 2020?), -B means run as daemon in background:
  wpa_supplicant -D nl80211 -i $wlan -c $wpasupconfpath $background
else
  echo "Running for LAN - disabling WLAN"
fi

# Is this script called with a second argument?:
if [ "$2" ]; then
  case $2 in 
    wifi1) 
      echo "wifi1";
      ip="1.2.3.4/24";
      gateway="1.2.3.1";;
    wifi2) 
      echo "wifi2";
      ip="1.2.3.4/24";
      gateway="1.2.3.1";;
    *)
      if [ "$3" ]; then
        ip=$2
        gateway=$3
      else
        # default
        echo "Need to pass in a default gateway as well when passing in an IP"
      fi
  esac
  ip addr add $ip dev $devup
  ip route add default via $gateway
else 
  # -4 means only request an IPv4 address
  #  --nohook resolv.conf means it won't touch/overwrite my resolv.conf! Leave it alone!
  echo "DHCP:"
  dhcpcd -4 $devup --nohook resolv.conf & 2>/dev/null
fi
