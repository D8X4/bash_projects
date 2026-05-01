#!/bin/bash

echo "name: "$(whoami)
sleep 1

echo "uptime: " $(uptime)
sleep 1
echo "space avaliable: " $(df -h --total | tail -1)
sleep 1
echo "free ram: " $(free -h | grep Mem)

read -p "open htop?: " choice
if [ "$choice" == "y" ]
then
htop
fi
echo "end"
