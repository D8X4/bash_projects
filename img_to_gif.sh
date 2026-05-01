#!/bin/bash
read -p "insert image name: " image
read -p "insert gif name: " gif
if [ ! -f ~/Pictures/"$image.png" ]
then
echo "file not found"
exit 1
fi
convert ~/Pictures/"$image.png" ~/Pictures/gifs/"$gif.gif"
echo "done; saved to ~/Pictures/gifs/"
