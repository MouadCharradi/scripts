#!/bin/bash

# echo "mouad"
battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')

# Battery 0: Discharging, 13%, 00:52:52 remaining
# To get the battery percentage only we'll cut the
# second value which ends at ", ". So we get 13%
# Now we'll replace the % sign by "", so 13% will
# be changed to 13 now.
# acpi -b produces output as
# echo $battery_level    #$battery_level=13

# If the charger is plugged in, acpi shows "charging"
# and if it's not plugged in, it shows "discharging".
# if acpi -b shows charging, "grep -c" will return 1
# else it will return 0
ac_power=$(acpi -b | grep -c "Charging")
# echo $ac_power         #1 if charging(plugged in) and 0 if discharging (not plugged in)

# when the battery is not charging
# and it goes below 30%

if [[ $ac_power -eq 0 && $battery_level -lt 30 ]]
then

    export DISPLAY=:0.0 &&
    sudo -u mouad DISPLAY=: 0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send -u critical "mouad, Battery is Low." "Level: $battery_level% "


    # similarily, it narrates
    #"please connect the charger"
    espeak "mouad, Battery is Low, Please connect the charger" -s 140

fi
