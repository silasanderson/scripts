#!/bin/sh

XHC=$(grep XHC /proc/acpi/wakeup | awk '{print $3}' | sed -n 1p)
LID=$(grep LID /proc/acpi/wakeup | awk '{print $3}' | sed -n 1p)

if [[ $XHC = "*enabled" ]]; then
	echo XHC | sudo tee /proc/acpi/wakeup > /dev/null
fi

if [[ $LID = "*enabled" ]]; then
	echo LID | sudo tee /proc/acpi/wakeup > /dev/null
fi
