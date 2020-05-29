# purpose:
# check if wifi exists
# if wifi does not exist, then wpa_supplicant operation
# check if wifi exists
# output success or failure

WIFI_SUCCESS="Wifi Connection Exists!"

if ping -c 1 google.com; then
	echo "$WIFI_SUCCESS"
	exit
fi