#!/bin/bash
# disconnect from AP
wpa_cli -i wlan0 disconnect;
# kill wpa_supplicant process stop STA mode
sudo killall wpa_supplicant;
# configure static IP on wlan0 interface
sudo ifconfig wlan0 192.168.4.1 netmask 255.255.255.0;
# start dhcp services 
sudo systemctl start dnsmasq.service;
# start AP  
sudo systemctl start hostapd.service;
