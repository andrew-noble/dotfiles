#!/bin/bash

if xrandr | grep -q "DisplayPort-2 connected"; then # external monitor is plugged in
  xrandr --output DisplayPort-2 --mode 3840x2160 --rate 60 --left-of eDP
else
  # fallback if not plugged
  xrandr --auto
fi
