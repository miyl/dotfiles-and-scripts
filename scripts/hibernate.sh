#! /usr/bin/env bash

xmessage "Hibernating in 15 seconds. Type 'killall hibernate.sh' to cancel."
sleep 15
killall xmessage
sudo pm-hibernate

<< Comment
read WISH

if [ $WISH = "n" ] ; then
exit
fi

if [ $WISH = "y" ] ; then

Comment

