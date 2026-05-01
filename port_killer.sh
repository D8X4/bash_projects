#!/bin/bash

read -p "port number: " port
PID=$(lsof -i :$port | awk 'NR==2{print $2}')

if [ -z "$PID" ]
then
echo "nothing running on port $port"
else
echo "killing $PID"
kill $PID
echo "killed process on port $port"
fi
