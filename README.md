## raspberryPiApSta

Switch the raspberry pi WiFi between AP and STA mode

### Setup

1. copy all the bash scripts in the scripts directory to the home directory (/home/pi)

   > cp /path/to/repo/scrpits/\* /home/pi

   > sudo chmod +x nwk_status.sh start_ap.sh stop_ap.sh

2. install hostapd and dnsmasq packages with the below commands.
   > sudo apt install hostapd dnsmasq
3. disable wpa_supplicant.service hostapd.service and dnsmasq.service from running on boot.
   > sudo systemctl disable wpa_supplicant.service hostapd.service dnsmasq.service
4. copy the files in conf directory to the respective location.

   > sudo cp /path/to/repo/conf/dnsmasq.conf /etc/dnsmasq.conf

   > sudo cp /path/to/repo/conf/hostapd.conf /etc/hostapd/hostapd.conf

5. copy the nwk_status.service file into /etc/systemd/system/nwk_status.service
   > sudo cp /path/to/repo/nwk_status.service /etc/systemd/system/nwk_status.service
6. enable nwk_status.service to run on boot.
   > sudo systemctl enable nwk_status.service
7. reboot the pi
   > sudo reboot

### Usage

If the pi is not associate to a network it will start and AP with ssid RpiAP.
You can edit the hostapd.conf as per your needs.

### References

1. [Rpi as WiFi AP](https://www.raspberrypi.org/documentation/configuration/wireless/access-point-routed.md)
