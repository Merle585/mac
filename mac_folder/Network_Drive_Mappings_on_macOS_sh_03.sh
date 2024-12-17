#!/bin/bash
# Script to Map Network Drives using dynamically generated SMB paths
# The SMB path uses the first uppercase letter of the username

# Function to delay until the user has finished setup assistant.
waitForDesktop () {
  until ps aux | grep /System/Library/CoreServices/Dock.app/Contents/MacOS/Dock | grep -v grep &>/dev/null; do
    delay=$(( RANDOM % 50 + 10 ))
    echo "$(date) |  + Dock not running, waiting [$delay] seconds"
    sleep $delay
  done
  echo "$(date) | Dock is here, let's carry on"
}

waitForDesktop

# Get the current username
username=$(whoami)

# Extract the first letter of the username and capitalize it
first_letter="${username:0:1}"
first_letter=$(echo "$first_letter" | tr '[:lower:]' '[:upper:]')  # Capitalize the first letter

# Define the dynamic SMB path using the capitalized first letter and the username
smb1="smb://path/to/SMD/server$first_letter/$username"  # Path based on the first letter and username
smb2="smb://path/to/SMD/server"         # Example additional SMB path
smb3="smb://path/to/SMD/server"                   # Another example SMB path

# Mount the SMB shares
mntcmd1="mount volume \"$smb1\""
mntcmd2="mount volume \"$smb2\""
mntcmd3="mount volume \"$smb3\""

# Use AppleScript to mount the shares
/usr/bin/osascript -e "$mntcmd1"
/usr/bin/osascript -e "$mntcmd2"
/usr/bin/osascript -e "$mntcmd3"

# Wait for the shares to mount
sleep 25

# Check if directories exist in /Volumes and print results
if [ -d "/Volumes/$username" ]; then
  echo "$(date) | Directory for $username is mounted."
  # Create alias on Desktop for the mounted directory
  osascript -e "tell application \"Finder\" to make new alias file at desktop to POSIX file \"/Volumes/$username\""
  # Add to the Dock
  osascript -e "tell application \"System Events\" to make new Dock item at end of dock items with properties {file name:\"$HOME/Desktop/$username\"}"
else
  echo "$(date) | Directory for $username failed to mount."
fi

if [ -d "/Volumes/auditing-groupdirs" ]; then
  echo "$(date) | Auditing Groupdirs is mounted."
  # Create alias on Desktop for the mounted directory
  osascript -e "tell application \"Finder\" to make new alias file at desktop to POSIX file \"/Volumes/auditing-groupdirs\""
  # Add to the Dock
  osascript -e "tell application \"System Events\" to make new Dock item at end of dock items with properties {file name:\"$HOME/Desktop/auditing-groupdirs\"}"
else
  echo "$(date) | Auditing Groupdirs failed to mount."
fi

if [ -d "/Volumes/Groupdir" ]; then
  echo "$(date) | Groupdir is mounted."
  # Create alias on Desktop for the mounted directory
  osascript -e "tell application \"Finder\" to make new alias file at desktop to POSIX file \"/Volumes/Groupdir\""
  # Add to the Dock
  osascript -e "tell application \"System Events\" to make new Dock item at end of dock items with properties {file name:\"$HOME/Desktop/Groupdir\"}"
else
  echo "$(date) | Groupdir failed to mount."
fi
