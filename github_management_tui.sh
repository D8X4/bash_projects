#!/bin/bash
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
# git check to see if it exist
git rev-parse --git-dir > /dev/null 2>&1 || { whiptail --msgbox "Not a git repository." 10 40; exit 1; }

# functions for the thing to even work
# menu function
main_menu() {
  choice=$(whiptail --title "Github Dashboard" --menu "Github Dashboard Selection" 20 60 10 \
   "1" "Status" \
   "2" "Add Files" \
   "3" "Commit" \
   "4" "Push" \
   "5" "Pull" \
   "6" "Log" \
   "7" "Exit" \
   3>&1 1>&2 2>&3)
  echo "$choice"
}

git_status() {
  tmpfile=$(mktemp)
  git status > "$tmpfile"
  whiptail --title "Git Repo Status" --scrolltext --textbox "$tmpfile" 20 70
  rm $tmpfile
}

git_addfile() {
  itemlist=$(git status --short | awk '{print $2}')
  if [ -z "$itemlist" ]; then
    whiptail --title "Git Repo Add File" --msgbox "Nothing to add" 20 70
    return
  fi
  items=()
  for file in $itemlist; do
    items+=("$file" "" "OFF")
  done
  selected=$(whiptail --checklist "Select files to add:" 20 70 10 "${items[@]}" 3>&1 1>&2 2>&3)
  for file in $selected; do
      file="${file//\"/}"
      git add "$file"
  done 
   whiptail --title "Git Repo Addition Complete" --msgbox "File Added to Repo" 20 70
}

git_commit() {
  message=$(whiptail --title "Git Commit" --inputbox "Commit message:" 20 70 3>&1 1>&2 2>&3)
  git commit -m "$message"
  whiptail --title "Git Commit Completed" --msgbox "Commit added to repo" 10 60
}

git_push() {
  git push
  whiptail --title "Git Push Completed" --msgbox "Pushed to git repo" 10 60
}

git_pull() {
  git pull --rebase
  whiptail --title "Git Pull Complete" --msgbox "Pulled changes from repo" 10 60
}

git_log() {
  tmpfile=$(mktemp)
  git log --oneline > "$tmpfile"
  whiptail --title "Git Repo Log" --scrolltext --textbox "$tmpfile" 20 70
  rm "$tmpfile"
}

# loop to get this thing going
while true; do
  choice=$(main_menu)
  case $choice in
    1) git_status ;;
    2) git_addfile ;;
    3) git_commit ;;
    4) git_push ;;
    5) git_pull ;;
    6) git_log ;;
    7) break ;;
    "") break ;;
  esac    
done
