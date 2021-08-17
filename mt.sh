#!/bin/sh

hour=$(date "+%k") 
min=$(date "+%M") 
sec=$(date "+%S") 

ms=$(echo "($min * 60 + $hour * 3600 + $sec) / .864" | bc)

case $1 in
		-s)
				echo $ms
		;;
		-m)
				echo "$ms / 100" | bc
		;;
		-h)
				echo "$ms / 10000" | bc
		;;
		-so)
				echo "${ms:3:2}" 
		;;
		-mo)
				echo "${ms:1:2}" 
		;;
		-ho)
				echo "${ms:0:1}" 
		;;
		-hm)
				echo "${ms:0:1}:${ms:1:2}" 
		;;
		-hms)
				echo "${ms:0:1}:${ms:1:2}:${ms:3:2}" 
		;;
		"")
				echo "${ms:0:1}:${ms:1:2}:${ms:3:2}" 
		;;
		  *)
			echo mt: Unknown option argument: "$@"
		  # echo More info with "wttr -h"
			;;
esac
