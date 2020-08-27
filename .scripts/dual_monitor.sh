#!/usr/bin/env /bin/bash

if [[ "$HOSTNAME" == "megatron" ]]; then
    /usr/bin/xrandr --output HDMI-1 --primary --auto --output HDMI-2 --left-of HDMI-1 --auto
fi
