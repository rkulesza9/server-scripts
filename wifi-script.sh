# purpose:
# check if wifi exists
# if wifi does not exist, then wpa_supplicant operation
# check if wifi exists
# output success or failure

ESSID="$1"
PASSWORD="$2"
INTERFACE="$3"

WIFI_SUCCESS='Wifi Connection Exists!'
WIFI_FAILURE='Wifi Connection Failure!'


help(){
	local HELP='--help'
	local HELP_MSG='args = [ESSID] [PASSWORD] [INTERFACE]'
	if [[ "$ESSID" == "$HELP" ]]; then
		echo "$HELP_MSG"
	fi
}

wifi_connected(){
	if ping -c 1 google.com; then
		echo -e "$1"
	else
		echo -e "$2"
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
	local DUCK="duck"
	echo "$ESSID $PASSWORD $INTERFACE"
	echo "$DUCK"
}

main(){
	if help; then
		exit
	elif [[ "$(wifi_connected SUCCESS FAILURE)" == "FAILURE" ]]; then
		wifi_connect
		echo wifi_connected "$WIFI_SUCCESS" "$WIFI_FAILURE"
	else 
		echo "$WIFI_SUCCESS"
	fi
}

main