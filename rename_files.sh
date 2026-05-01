read -p "enter file path; " path
read -p "what would you like to rename them to; " name

for file in $path/*
do
mv  "$file" "$path/${name}_$(basename $file)"
done

notify-send "Rename complete" "DONE"
