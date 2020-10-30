#!/bin/sh

# echo $(cat /sys/class/power_supply/BAT0/capacity /sys/class/power_supply/BAT1/capacity)
if [ $(cat /sys/class/power_supply/AC/online) = 1 ]; then echo + $(cat /sys/class/power_supply/BAT0/capacity /sys/class/power_supply/BAT1/capacity) ; else echo $(cat /sys/class/power_supply/BAT0/capacity /sys/class/power_supply/BAT1/capacity) ; fi
