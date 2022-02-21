#!/bin/sh

arg=$1
[ $arg = "UP"   ] && xbacklight -inc 10
[ $arg = "DOWN" ] && xbacklight -dec 10
