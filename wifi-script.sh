# purpose:
# check if wifi exists
# if wifi does not exist, then wpa_supplicant operation
# check if wifi exists
# output success or failure

WIFI_SUCCESS='\n\nWifi Connection Exists!'

if ping -c 1 google.com; then
	echo -e "$WIFI_SUCCESS"
	cd "/$1"
	pwd
	exit
fi

# rfkill unblock wifi
# iwlist "$1" 