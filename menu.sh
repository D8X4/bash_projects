#!/bin/bash

while true
do
clear
#choices
toilet -f mono9 "D8X4's Menu"
echo "choices:"
echo -e "1) python 3  2) htop\n3) bashtop   4) asquarium\n5) ff        6) ncdu\n7) clock     8) cava\n9) bottom   10) pinger\n11) new script 12) empty trash\n13) img > gif 14) ani-cli\n15) continue anime 16) cacafire\n17)cacademo 18) cmus music " | boxes -d simple
echo "q to quit"

#script logic
read -p "enter choice; " choice
case $choice in
1) python3 ;;
2) htop ;;
3) bashtop ;;
4) asciiquarium ; read -p 'press enter to return' ;;
5) fastfetch ; read -p "press enter to return" ;;
6) cd ~/ && ncdu -e ;;
7) tty-clock -s -x -c -C 6 -t 2>/dev/null ; read -p "press enter to return" ;;
8) cava ;;
9) bottom ;;
10) ping -D -c 4 google.com ; read -p "press enter to return" ;;
11) ~/Scripts/new_script.sh  ;;
12) ~/Scripts/empty_trash.sh  ;;
13) ~/Scripts/img_to_gif.sh ; read -p "press enter to return" ;;
14) ~/Scripts/animewatching.sh ;;
15) ~/Scripts/continueanime.sh ;;
16) cacafire ; read -p 'press enter to return' ;;
17) cacademo ; read -p 'press enter to return' ;;
18) cmus ; read -p 'press enter to return' ;;
q) break ;;
*) echo "invalid";;
esac
done
