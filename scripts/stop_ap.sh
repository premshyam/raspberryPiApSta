#!/bin/bash

# stop the nwk_status.service
sudo systemctl stop nwk_status.service

if [ $? -eq 0 ]
then
	echo "stopped nwk_status.service"
else
	echo "failed to stop nwk_status.service"
	exit 1
fi
# stop the hostapd service (stops AP mode)
sudo systemctl stop hostapd.service

if [ $? -eq 0 ]
then
	echo "stopped hostapd.service"
else
	echo "failed to stop hostapd.service"
	exit 1
fi
# stop the dnsmasq service
sudo systemctl stop dnsmasq.service

if [ $? -eq 0 ]
then
	echo "stopped dnsmasq.service"
else
	echo "failed to stop dnsmasq.service"
	exit 1
fi
# release IP from wlan0 interface
sudo ifconfig wlan0 0

if [ $? -eq 0 ]
then
	echo "released ip from wlan0 interface"
else
	echo "failed to stop hostapd.service"
	exit 1
fi
# switch to STA mode 
sudo wpa_supplicant -B -c/etc/wpa_supplicant/wpa_supplicant.conf -iwlan0 -Dnl80211,wext

if [ $? -eq 0 ]
then
	echo "running wpa_supplicant"
else
	echo "failed to run wpa_supplicant"
	exit 1
fi
# configure desired SSID
wpa_cli -i wlan0 set_network 0 ssid $1

if [ $? -eq 0 ]
then
	echo "set the SSID"
else
	echo "failed to set SSID"
	exit 1
fi
# configure desired Password
wpa_cli -i wlan0 set_network 0 psk $2

if [ $? -eq 0 ]
then
	echo "set the psk"
else
	echo "failed to set the psk"
	exit 1
fi
# saves the configuration to /etc/wpa_supplicant/wpa_supplicant.conf
wpa_cli -i wlan0 save_config

if [ $? -eq 0 ]
then
	echo "saved the configuration"
else
	echo "failed to saved the configuration"
	exit 1
fi
# force wpa_supplicant to re-read its configuration file
wpa_cli -i wlan0 reconfigure

if [ $? -eq 0 ]
then
	echo "reconfigure wlan0"
else
	echo "failed to reconfigure wlan0"
	exit 1
fi
# restart the nwk_status service
sleep 30 && sudo systemctl start nwk_status.service &

# if [ $? -eq 0 ]
# then
# 	echo "started nwk_status.service"
# else
# 	echo "failed to start nwk_status.service"
# 	exit 1
# fi

