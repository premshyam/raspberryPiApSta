#!/bin/bash
ap_mode=false
while :
do
	if [ $(hostname -I) == "192.168.4.1" ]
	then
		ap_mode=true
		echo "Device hotspot enabled"
	fi
	if [ $ap_mode == false ]
	then
		#get configured SSID 
		SSID=$(wpa_cli -i wlan0 get_network 0 ssid)
		#check if connected to AP
		OUTPUT=$(iwconfig wlan0 | grep -c "$SSID")
		if [ "$OUTPUT" == "0" ]
		then
			echo "Not associated to AP"
			/home/pi/start_ap.sh
			ap_mode=true
		else
			echo "Associate to AP"
		fi
	fi
	sleep 10
done
