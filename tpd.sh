#!/bin/sh

id=$(echo -e "point\ntrack" | dmenu -i -p 'togele')

case $id in
		point)
				device="TPPS/2 IBM TrackPoint"
				;;
		track)
				device="Synaptics TM3276-022"
				;;
		*)
				exit
				;;
esac

state=`xinput list-props "$device" | grep "Device Enabled" | grep -o "[01]$"`

if [ "$state" -eq '1' ];then
  xinput --disable "$device"
else
  xinput --enable "$device"
fi
