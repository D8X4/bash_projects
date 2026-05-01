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

# functions for the thing to even work
# menu function
main_menu() {
  choice=$(whiptail --title "Cron Job Manager" --menu "Cron Job Selector" 20 60 10 \
   "1" "View Jobs" \
   "2" "Add Job" \
   "3" "Delete Job" \
   "4" "Toggle Job" \
   "5" "Quit" \
   3>&1 1>&2 2>&3)
  echo "$choice"

}

# view job function
view_jobs() {
  jobs=$(crontab -l 2>/dev/null | grep -v "^#[^~]" | grep -v "^$")
  if [ -z "$jobs" ]; then
  whiptail --title "Cron Jobs" --msgbox "No Cron Jobs found" 10 40
  else
  whiptail --title "Cron Jobs" --msgbox "$jobs" 20 60
  fi
  
}
# add job function | adds cronjobs with scheduling included 
add_job() {
  time_choice=$(whiptail --title "Cron Job Creation" --menu "Cron Job Creation" 20 60 10 \
  "1" "Every minute (* * * * *)"\
  "2" "Every hour (0 * * * *)"\
  "3" "Every day at midnight (0 0 * * *)"\
  "4" "Every week (0 0 * * 0)"\
  "5" "Custom (enter manually)"\
  3>&1 1>&2 2>&3)
  
  
  case $time_choice in
    1) schedule="* * * * *" ;;
    2) schedule="0 * * * *" ;;
    3) schedule="0 0 * * *" ;;
    4) schedule="0 0 * * 0" ;;
    5) schedule=$(whiptail --inputbox "Enter cron expression:" 10 60 3>&1 1>&2 2>&3) ;;
  esac
command=$(whiptail --inputbox "Enter command to run:" 10 60 3>&1 1>&2 2>&3)
(crontab -l 2>/dev/null ; echo "$schedule $command") | crontab -
whiptail --msgbox "Job Added:\n$schedule $command" 10 60

}

# delete job function
# delete a cronjob from crontab  
delete_job() {
  mapfile -t jobs < <(crontab -l 2>/dev/null | grep -v "^#[^~]" | grep -v "^$")

  if [ ${#jobs[@]} -eq 0 ]; then
    whiptail --title "Delete Job" --msgbox "No Cronjobs found" 10 40
    return
  fi

  menu_items=()
  for i in "${!jobs[@]}"; do
    menu_items+=("$((i+1))" "${jobs[$i]}")
  done

  selected=$(whiptail --title "Delete Job" --menu "Select job to delete:" 20 78 10 \
    "${menu_items[@]}" 3>&1 1>&2 2>&3)

  [ -z "$selected" ] && return

  new_crontab=()
  for i in "${!jobs[@]}"; do
    [ $((i+1)) -ne "$selected" ] && new_crontab+=("${jobs[$i]}")
  done

  printf "%s\n" "${new_crontab[@]}" | crontab -
  whiptail --title "Delete Job" --msgbox "Job deleted." 10 40
}

# toggle job function
# allows user to toggle certain cronjobs in crontab
toggle_job() {
  mapfile -t jobs < <(crontab -l 2>/dev/null | grep -v "^#[^~]" | grep -v "^$")

  if [ ${#jobs[@]} -eq 0 ]; then
    whiptail --title "Toggle Job" --msgbox "No cron jobs found" 10 40
    return
  fi

  menu_items=()
  for i in "${!jobs[@]}"; do
    menu_items+=("$((i+1))" "${jobs[$i]}")
  done

  selected=$(whiptail --title "Toggle Job" --menu "Select job to enable/disable:" 20 78 10 \
    "${menu_items[@]}" 3>&1 1>&2 2>&3)

  [ -z "$selected" ] && return

  if [[ "${jobs[$((selected-1))]}" == "#~"* ]]; then
    toggled="${jobs[$((selected-1))]#\#~}"
  else
    toggled="#~${jobs[$((selected-1))]}"
  fi

  new_crontab=()
  for i in "${!jobs[@]}"; do
    if [ $((i+1)) -eq "$selected" ]; then
      new_crontab+=("$toggled")
    else
      new_crontab+=("${jobs[$i]}")
    fi
  done

  printf "%s\n" "${new_crontab[@]}" | crontab -
  whiptail --title "Toggle Job" --msgbox "Job toggled." 10 40
}
# "1" "View Jobs" "2" "Add Job" "3" "Delete Job" "4" "Toggle Job" "5" "Quit" 
while true; do
  choice=$(main_menu)
  case $choice in
    1) view_jobs ;;
    2) add_job ;;
    3) delete_job ;;
    4) toggle_job ;;
    5) break ;;
    "") break ;;
  esac    
done

# made by d8x4
