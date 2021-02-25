#!/bin/bash
while :
do
	#get configured SSID 
	SSID=$(wpa_cli -i wlan0 get_network 0 ssid)
	#check if connected to AP
	OUTPUT=$(iwconfig wlan0 | grep -c $SSID)
	if [ "$OUTPUT" = "0" ]
	then
		echo "Not associated to AP"
		/home/pi/start_ap.sh
	else
		echo "Associate to AP"
	fi
	sleep 5
done
