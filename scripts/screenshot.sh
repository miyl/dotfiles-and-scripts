#! /usr/bin/env bash

# for testing:
#pwd > /home/lys/info.txt

#path='/home/lys/sh/';
screenshot='screenshot';
nano=`date '+%d-%m-%y-%N'`;
extension='.png';
file="$HOME/screenshots/$screenshot-$nano$extension";

#sleep 3; 
#scrot -s -b -q 0 $file
sleep 2 && import -window root $file
#pid=!$
#wait $pid

exit 0

