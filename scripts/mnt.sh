#! /usr/bin/env sh

mountPoint="/mnt/q"
i=0

# Translates a zero-indexed number into a device name. It's zero-indexed so fx. sdb5 is 5 instead of 6 because sdb (the entire disk) would otherwise be 1
getDev() {
  for aDev in $(lsblk -l -n -o NAME | grep -Ev 'sda|data'); do
    
    if [ "$1" -eq $i ]; then
      dev=$aDev
      break
    else
      i=$((i+1))
    fi

  done
}

# Check that the right number of arguments were given
if [ -n "$2" ] && [ -z "$3" ]; then 

  if [ "$2" = "w" ]; then
    win="-o uid=$USER"
  fi

  # A sneaky way I read about for checking whether $1 is numeric. If it is call getDev
  if [ "$1" -eq "$1" ] 2> /dev/null ; then
    getDev $1
  else
    dev=$1
  fi

  sudo mount $win /dev/$dev $mountPoint

else
  printf '%s\n\n' "mnt simplifies mounting." \
  \
          "Listing block devices except sda (if any!):"
  # -o is used to minimize the number of columns printed out. See the ID of a device by simply running lsblk and checking the MAJ column
  lsblk -o NAME,FSTYPE | grep -Ev 'sda|data'
  printf '%s\n' "" "mnt takes 3 arguments: 2 required and 1 optional" \
    "1st: The device to mount: can be a partition name (fx. 'sdc1' or 'mmcblk0p1') or a number (10 mounts partition number 10 listed by doing mnt)" \
    "2nd: 'l' or 'w', indicating Linux or Windows. For Windows -o uid=$USER is added to ensure that regular users have rw permission to the mount and not just root"
fi
