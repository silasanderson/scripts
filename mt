#!/bin/sh

hour=$(date "+%k") 
min=$(date "+%M") 
sec=$(date "+%S") 

ms=$(echo "($min * 60 + $hour * 3600 + $sec) / .864" | bc)

echo "${ms:0:1}:${ms:1:2}:${ms:3:2}" 
