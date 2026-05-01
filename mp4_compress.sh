#!/bin/bash
read -p "Input file path: " input
echo "let the script run itll take a bit"
ffmpeg -i "$input" -vcodec libx264 -crf 28 -vf scale=1280:-2 "${input%.*}_compressed.mp4"
echo "compression finished"
