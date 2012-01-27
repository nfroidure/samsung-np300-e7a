#!/bin/bash
# TODO: Change above to /bin/sh

test -f /usr/share/acpi-support/key-constants || exit 0

BRIGHTNESS=$(cat /sys/class/backlight/acpi_video0/brightness)

if [ "$BRIGHTNESS" -gt 7 ]; then
	BRIGHTNESS=0
fi

if [ "x$1" = "xdown" ]; then
   if [ "x$BRIGHTNESS" != "x0" ]; then
      BRIGHTNESS=$(( $BRIGHTNESS - 1 ))
      echo $BRIGHTNESS > /sys/class/backlight/acpi_video0/brightness
      echo $BRIGHTNESS > /sys/class/backlight/acpi_video1/brightness
   fi
elif [ "x$1" = "xup" ]; then
   if [ "x$BRIGHTNESS" != "x7" ]; then
      BRIGHTNESS=$(( $BRIGHTNESS + 1 ))
      echo $BRIGHTNESS > /sys/class/backlight/acpi_video0/brightness
      echo $BRIGHTNESS > /sys/class/backlight/acpi_video1/brightness
   fi
else
   echo >&2 Unknown argument $1
fi

echo "Brightness $1 : $BRIGHTNESS" > /dev/tty1
