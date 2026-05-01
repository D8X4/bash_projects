#!/bin/bash
cd ~/Scripts
# Get a list of all .sh files in your Scripts folder
SCRIPT=$(ls ~/Scripts/*.sh | xargs -n 1 basename | rofi -dmenu -p "Run Script:")

# If you didn't hit escape, execute it in this terminal
if [ -n "$SCRIPT" ]; then
    clear
    ./"$SCRIPT"
fi
