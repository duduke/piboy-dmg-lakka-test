#!/bin/bash
insmod /storage/roms/piboy-dmg/xpi_gamecon.ko
while [ 2 -gt 1 ]
do
	sleep 1
	VOL=`cat /sys/kernel/xpi_gamecon/volume`
	TEMP=`cat /sys/class/thermal/thermal_zone0/temp`
	SHUTDOWN=`cat /sys/kernel/xpi_gamecon/status`
	echo $TEMP
	echo $VOL
	amixer -M set Headphone $VOL%
	if [[ $TEMP -gt 70000 ]]  
	then
		echo 100 > /sys/kernel/xpi_gamecon/fan
	else
		echo 0 > /sys/kernel/xpi_gamecon/fan 
	fi
	if [[ $SHUTDOWN -eq 6 ]]
	then
		echo "0" > /sys/kernel/xpi_gamecon/flags
		/usr/sbin/rmmod xpi_gamecon
		/usr/sbin/poweroff
	fi
done
