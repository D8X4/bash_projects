#!/bin/bash
read -p "enter name of backup: " name
read -p "enter full path to directory to backup: " backup_path

filename="${name}.tar.gz"

if [ -f "$filename" ]; then
read -p "file exist do you want to overwrite (y/n)" choice
if [ $choice == 'y' ]; then
read -p "enter new name for backup: " name
filename=${name}.tar.gz
else
echo 'finished'
exit 1
fi
fi
tar -czvf "$filename" "$backup_path"
