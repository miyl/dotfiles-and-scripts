#! /usr/bin/env sh

help() {
  printf '%s\n' "Available commands:" \
    "--init: Starts the CUPS web service, required for printing. It runs on localhost:631" \
    "--locate: Port scans an IP range to find the IP of the printer, if you don't know it. Specify an IP without the last part, like 192.168.1, and it will ping those 266 IPs and report which are responding." \
    "" \
    "Specifically new printers are added on http://localhost:631/admin" \
    "If you click 'Find new printers' CUPS can also try to auto-find the printer for you!" \
    "When adding a new printer it asks for a username and password. This is just your regular linux users. You can use root, or if your user has been added to the 'lp' group it may work to use your regular user."
}

if [ -n "$1" ] ; then

  if [ "$1" = "--init" ] ; then
    sudo systemctl start org.cups.cupsd
    echo "CUPS web service now running on localhost:631"

  elif [ "$1" = "--locate" ] ; then
    echo "Pinging the subnet. One of the responding IPs is probably the printer."
    nmap -sP ${2}.0-255

  elif [ "$1" = "--list" ] ; then
    echo "Listing printers:"
    lpstat -s
  else
    help
  fi
else
  help
fi
