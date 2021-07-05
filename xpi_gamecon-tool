#!/bin/bash
while [ 2 -gt 1 ]
do
	sleep 1
	VOL=`cat /sys/kernel/xpi_gamecon/volume`
	TEMP=`cat /sys/class/thermal/thermal_zone0/temp`
	echo $TEMP
	echo $VOL
	amixer -M set Headphone $VOL%
	if [[ $TEMP -gt 70000 ]]  
	then
		echo 100 > /sys/kernel/xpi_gamecon/fan
	else
		echo 100 > /sys/kernel/xpi_gamecon/fan 
	fi
done
