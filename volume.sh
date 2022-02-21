#!/bin/sh

arg=$1
[ $arg = "up"      ] && pactl set-sink-volume 0 +5dB
[ $arg = "down"    ] && pactl set-sink-volume 0 -5dB
[ $arg = "toggle"  ] && pactl set-sink-mute   0 toggle

#pkill -RTMIN+10 slstatus
#slstatus

pkill -RTMIN+5 dwmblocks
