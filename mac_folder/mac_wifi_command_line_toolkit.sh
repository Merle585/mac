## mac_wifi_command_line_toolkit

#!/bin/bash

# Wi-Fi Interface (default is usually "en0" for macOS; confirm with list_interfaces function if needed)
WIFI_INTERFACE="en0"

# Display available options for the user
echo "Wi-Fi Command Line Toolkit for macOS"
echo "==================================="
echo "1. List all network interfaces"
echo "2. Connect to a Wi-Fi network"
echo "3. Disconnect from Wi-Fi"
echo "4. Reconnect Wi-Fi"
echo "5. Get current Wi-Fi connection information"
echo "6. Turn Wi-Fi off"
echo "7. Turn Wi-Fi on"
echo "8. Forget a Wi-Fi network"
echo "9. Add a Wi-Fi network to preferred networks"
echo "10. List preferred Wi-Fi networks"
echo "11. Ping a network address"
echo "12. Release & Renew IP Address (DHCP)"
echo "13. Open Wi-Fi Diagnostics tool"
echo "==================================="
echo "Select an option (1-14):"
read -r option

# Define each function for respective Wi-Fi operations

# 1. List all network interfaces
list_interfaces() {
    # Lists all hardware network interfaces, including the Wi-Fi interface
    networksetup -listallhardwareports
}

# 2. Connect to a Wi-Fi network
connect_wifi() {
    # Connects to a specified Wi-Fi network using SSID and password
    echo "Enter the SSID (Wi-Fi name):"
    read -r ssid
    echo "Enter the Wi-Fi password:"
    read -r -s password
    networksetup -setairportnetwork "$WIFI_INTERFACE" "$ssid" "$password"
}

# 3. Disconnect from Wi-Fi
disconnect_wifi() {
    # Temporarily disables the Wi-Fi interface
    sudo ifconfig "$WIFI_INTERFACE" down
}

# 4. Reconnect Wi-Fi
reconnect_wifi() {
    # Re-enables the Wi-Fi interface
    sudo ifconfig "$WIFI_INTERFACE" up
}

# 5. Get current Wi-Fi connection information
get_wifi_info() {
    # Displays detailed info about the current Wi-Fi connection (SSID, BSSID, channel, signal strength, etc.)
    /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I
}

# 6. Turn Wi-Fi off
turn_wifi_off() {
    # Turns off the Wi-Fi service
    networksetup -setnetworkserviceenabled Wi-Fi off
}

# 7. Turn Wi-Fi on
turn_wifi_on() {
    # Turns on the Wi-Fi service
    networksetup -setnetworkserviceenabled Wi-Fi on
}

# 8. Forget a Wi-Fi network
forget_network() {
    # Removes a specified Wi-Fi network from the preferred networks list
    echo "Enter the SSID of the network to forget:"
    read -r ssid
    networksetup -removepreferredwirelessnetwork "$WIFI_INTERFACE" "$ssid"
}

# 9. Add a Wi-Fi network to preferred networks
add_preferred_network() {
    # Adds a Wi-Fi network to the preferred networks list with given priority and security type
    echo "Enter the SSID (Wi-Fi name):"
    read -r ssid
    echo "Enter network priority (1 is highest):"
    read -r priority
    echo "Enter security type (WEP/WPA2/WPA3):"
    read -r security
    echo "Enter the Wi-Fi password:"
    read -r -s password
    networksetup -addpreferredwirelessnetworkatindex "$WIFI_INTERFACE" "$ssid" "$priority" "$security" "$password"
}

# 10. List preferred Wi-Fi networks
list_preferred_networks() {
    # Lists all Wi-Fi networks the Mac has previously connected to, in preferred order
    networksetup -listpreferredwirelessnetworks "$WIFI_INTERFACE"
}

# 11. Ping a network address
ping_network() {
    # Pings a specified IP address or domain to check network connectivity
    echo "Enter IP address or domain to ping (e.g., 8.8.8.8 or google.com):"
    read -r address
    ping "$address"
}

# 12. Release and Renew IP Address (DHCP)
release_renew_ip() {
    # Releases and then renews the IP address for the Wi-Fi interface
    echo "Releasing IP..."
    sudo ipconfig set "$WIFI_INTERFACE" NONE
    echo "Renewing IP..."
    sudo ipconfig set "$WIFI_INTERFACE" DHCP

}

# 13. Open Wi-Fi Diagnostics tool
open_wifi_diagnostics() {
    # Opens macOS's built-in Wireless Diagnostics tool for troubleshooting
    open /System/Library/CoreServices/Applications/Wireless\ Diagnostics.app
}

# Run the selected function based on user input
case $option in
    1) list_interfaces ;;          # Lists all network interfaces
    2) connect_wifi ;;             # Connects to a Wi-Fi network
    3) disconnect_wifi ;;          # Disconnects from Wi-Fi
    4) reconnect_wifi ;;           # Reconnects to Wi-Fi
    5) get_wifi_info ;;            # Shows current Wi-Fi connection info
    6) turn_wifi_off ;;            # Turns Wi-Fi off
    7) turn_wifi_on ;;             # Turns Wi-Fi on
    8) forget_network ;;           # Forgets a Wi-Fi network
    9) add_preferred_network ;;   # Adds a Wi-Fi network to preferred networks
    10) list_preferred_networks ;; # Lists preferred Wi-Fi networks
    11) ping_network ;;            # Pings a network address
    12) release_renew_ip ;;        # Releases & renews IP address
    13) open_wifi_diagnostics ;;   # Opens Wi-Fi diagnostics tool
    *) echo "Invalid option. Please select a number from 1 to 13." ;;  # Error message for invalid input
esac