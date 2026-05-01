#!/bin/bash
read -p "host: " host
read -p "port1: " port1
read -p "port2: " port2

for port in $(seq $port1 $port2)
do
(echo > /dev/tcp/$host/$port) 2>/dev/null
if [ $? -eq 0 ]
then
echo "port $port is open"
fi
done
