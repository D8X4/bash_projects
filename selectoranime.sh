#!/bin/bash

while true; do
    CHOICE=$(echo -e "Watch anime\nContinue series\nRoll a random anime\nQuit" | rofi -dmenu -p "Execute:")

    if [ -z "$CHOICE" ] || [ "$CHOICE" == "Quit" ]; then
        break
    fi

    case "$CHOICE" in
        "Watch anime") 
            ./animewatching.sh ;;
        "Continue series") 
            ./continueanime.sh ;;
        "Roll a random anime") 
            while true; do
                PICK=$(~/PyProjects/venv/bin/python3 ~/PyProjects/randomanime.py)

                # We put the name INSIDE the list so it's theme-independent
                # "--- $PICK ---" acts as a header
                ACTION=$(echo -e "--- $PICK ---\nWatch it\nReroll\nBack to Menu" | rofi -dmenu -p "Selection:")

                if [ "$ACTION" == "Watch it" ] || [ "$ACTION" == "--- $PICK ---" ]; then
                    gnome-terminal -- ani-cli "$PICK"
                    break 2
                elif [ "$ACTION" == "Reroll" ]; then
                    continue 
                else
                    break 
                fi
            done
            ;;
    esac
done
