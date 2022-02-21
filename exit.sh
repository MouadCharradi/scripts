#!/bin/sh

choice=$(echo "Shutdown\nReboot\nExit" | dmenu -i -p "Choose action: ")

[ $choice = "Shutdown" ] && doas poweroff
[ $choice = "Reboot"   ] && doas reboot
[ $choice = "Exit"     ] && pkill dwm
