#!/bin/bash
# commands used for this script
# ip a)
# ss -tulnp)
# nmcli dev show)
# curl -s ifconfig.me)
# ping

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
  choice=$(whiptail --title "Network Dashboard" --menu "Network Dashboard Selection" 20 60 10 \
   "1" "view ip" \
   "2" "view socket stats" \
   "3" "view network manager" \
   "4" "view public ip" \
   "5" "Ping network check" \
   "6" "exit" \
   3>&1 1>&2 2>&3)
  echo "$choice"

}

view_ip() {
  tmpfile=$(mktemp)
  ip a > "$tmpfile"
  whiptail --title "IP Info" --scrolltext --textbox "$tmpfile" 20 70
  rm $tmpfile 
}

socket_stats() {
  tmpfile=$(mktemp)
  ss -tulnp > "$tmpfile"
  whiptail --title "Socket Stats" --scrolltext --textbox "$tmpfile" 20 70
  rm $tmpfile
}

network_man() {
  tmpfile=$(mktemp)
  nmcli dev show > "$tmpfile"
  whiptail --title "Network Manager Stuff" --scrolltext --textbox "$tmpfile" 20 70
  rm $tmpfile
}

curl_pubip() {
  pubip=$(curl -s ifconfig.me)
  whiptail --title "Public IP" --msgbox "$pubip" 20 70
}

ping_check() {
  host=$(whiptail --title "Ping Check" --inputbox "What host to ping:" 10 60 3>&1 1>&2 2>&3)
  pinger=$(ping -c 4 "$host")
  whiptail --title "Ping Check Complete" --msgbox "$pinger" 20 70
}

# loop to get this thing going
while true; do
  choice=$(main_menu)
  case $choice in
    1) view_ip ;;
    2) socket_stats ;;
    3) network_man ;;
    4) curl_pubip ;;
    5) ping_check ;;
    6) break ;;
    "") break ;;
  esac    
done
