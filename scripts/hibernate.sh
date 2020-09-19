#! /usr/bin/env sh

PID=`ps aux | grep hibernate.sh | head -n 1 | awk '{ print $2 }'`
#PID=`pidof hibernate.sh`
#xmessage "Hibernating in 15 seconds. Type 'kill $PID' to cancel."
notify-send "Hibernating in 15 seconds. Type 'kill $PID' to cancel."
sleep 15
#killall xmessage
sudo pm-hibernate

<< Comment
read WISH

if [ $WISH = "n" ] ; then
exit
fi

if [ $WISH = "y" ] ; then

Comment

