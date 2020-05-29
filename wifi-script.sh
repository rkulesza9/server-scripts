# purpose:
# check if wifi exists
# if wifi does not exist, then wpa_supplicant operation
# check if wifi exists
# output success or failure

ESSID="$1"
PASSWORD="$2"
INTERFACE="$3"


help(){
	local HELP='--help'
	local HELP_MSG='args = [ESSID] [PASSWORD] [INTERFACE]'
	if [["$ESSID" == "$HELP"]]; then
		echo "$HELP_MSG"
	fi
}

wifi_connected(){
	local WIFI_SUCCESS='\n\nWifi Connection Exists!'
	local WIFI_FAILURE='\n\nWifi Connection Failure!'

	if ping -c 1 google.com; then
		echo -e "$WIFI_SUCCESS"
	else
		echo -e "$WIFI_FAILURE"
	fi
}

wifi_connect(){
	local CONFIG='/etc/wpa_supplicant.conf'

	rfkill unblock wifi
	killall wpa_supplicant

	wpa_passphrase "$ESSID" "$PASSWORD" > "$CONFIG"
	wpa_supplicant -c "$CONFIG" -i "$INTERFACE" -B

	dhclient -v "$INTERFACE"
}

test_method(){
	local DUCK = "duck"
	echo "$ESSID $PASSWORD $INTERFACE"
	echo "$DUCK"
}

test_method