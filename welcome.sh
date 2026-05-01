#!/bin/bash
memory=$(free -h | grep Mem | awk '{print $7}')

echo "_______________________________"
echo " Welcome back, $(whoami)!"
echo " Date: $(date)"
echo " Free Memory: $memory"
echo " y / yazi to file explore"
echo " cmus for music player"
echo " zconf for config file"
echo " reload to reload conf file"
echo " z (directory) to tp around"
echo " fully clear ctrl+shift+del"
echo " for kitten keys; f1 or shift+~"
echo "_______________________________"
