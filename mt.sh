#!/bin/sh

while true; do


bat=$(bat.sh)
hour=$(date "+%k") 
min=$(date "+%M") 
sec=$(date "+%S") 

ms=$(echo "($min * 60 + $hour * 3600 + $sec) / .864" | bc)

xsetroot -name "$hour:$min:$sec  ${ms:0:1}:${ms:1:2}:${ms:3:2}  $bat"

sleep 1
done
