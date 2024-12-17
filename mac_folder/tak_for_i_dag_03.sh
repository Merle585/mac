#!/bin/bash

# Simulate Option + Command + Esc (Opens the Force Quit Applications window)
osascript -e 'tell application "System Events" to key down {option, command}'
osascript -e 'tell application "System Events" to key code 53'  # Esc key
osascript -e 'tell application "System Events" to key up {option, command}'

# Small delay to ensure the previous command is executed
sleep 0.5

# Simulate Command + A (Select All)
osascript -e 'tell application "System Events" to keystroke "a" using {command down}'

# Small delay to ensure the previous command is executed
sleep 0.5

# Simulate Enter
osascript -e 'tell application "System Events" to keystroke return'


# Simulate Enter
osascript -e 'tell application "System Events" to keystroke return'

