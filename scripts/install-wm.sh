#!/usr/bin/env bash

wm=(bspwm rofi sxhkd feh maim xclip fonts-font-awesome)

for tool in "${wm[@]}"
do
  sudo apt install "$tool"
done
