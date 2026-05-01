#!/bin/bash
# script uses sudo so if you dont like that read the script
# commands used for this script
# apt search
# apt install
# apt remove
# apt update && apt upgrade

# made by D8X4 on github
# customization of whiptail bc why not
export NEWT_COLORS='
root=,black
window=,black
border=white,black
title=white,black
listbox=white,black
actlistbox=black,white
actsellistbox=black,white
button=black,white
compactbutton=white,black
textbox=white,black
'

# functions for the thing to even work
# menu function
main_menu() {
  choice=$(whiptail --title "Package Manager Dashboard" --menu "Package Manager Dashboard Selection" 20 60 10 \
   "1" "Apt Search" \
   "2" "Apt Install" \
   "3" "Apt Remove" \
   "4" "Apt Update && Upgrade" \
   "5" "exit" \
   3>&1 1>&2 2>&3)
  echo "$choice"

}

apt_search() {
  tmpfile=$(mktemp)
  search=$(whiptail --title "Package Searcher" --inputbox "What Package do you want to search for:" 10 60 3>&1 1>&2 2>&3)
  apt search "$search" 2>/dev/null > "$tmpfile"
  whiptail --title "Package Search Complete" --scrolltext --textbox "$tmpfile" 20 70   
  rm "$tmpfile"
}

apt_install() {
  packagein=$(whiptail --title "Package Installer" --inputbox "What Package to install?" 10 60 3>&1 1>&2 2>&3)
  sudo apt install "$packagein" -y
  whiptail --title "Package Installer" --msgbox "$packagein installed successfully." 20 70
}

apt_remove() {
  packagein=$(whiptail --title "Package Remover" --inputbox "What Package to remove?" 10 60 3>&1 1>&2 2>&3)
  sudo apt remove "$packagein" -y
  whiptail --title "Package Remover" --msgbox "$packagein Removed successfully." 20 70
}

update_upgrade() {
  sudo apt update && sudo apt upgrade -y
}

# loop to get this thing going
while true; do
  choice=$(main_menu)
  case $choice in
    1) apt_search ;;
    2) apt_install ;;
    3) apt_remove ;;
    4) update_upgrade ;;
    5) break ;;
    "") break ;;
  esac    
done
