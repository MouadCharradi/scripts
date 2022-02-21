#!/bin/bash

tmpPID="/tmp/screencast.pid"
outputDIR="$HOME/screencast"
timeStamp=$(date '+%Y%m%d_%H%M%S')
outputFILE="$outputDIR/$timeStamp.mov"
mic=$(arecord -l | awk '/USB/ {sub(":",""); print $2}')

if [ -s $tmpPID ]
then
    kill $(cat $tmpPID)
    rm -rf $tmpPID
else
    ffmpeg -framerate 30 -video_size 1366x768 -f x11grab -i :0 -vcodec libx264 -preset fast -threads 0 -ac 1 -ab 320k "$outputFILE" & echo $! > $tmpPID
fi

# pkill -RTMIN+11 slstatus
# slstatus

pkill -RTMIN+10 dwmblocks
