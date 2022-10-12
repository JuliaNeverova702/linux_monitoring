#!/bin/bash

. ./config
. ./set_color
. ./../common/output

sudo ln -sf /../../../../usr/share/zoneinfo/Asia/Novosibirsk /etc/localtime

re='^[1-6]$'

if [[ $column1_background == $column1_font_color || $column2_background == $column2_font_color ]]; then
    echo -e "${COLOR_T[2]} Error: Enter difference color. Try again. ${ENDCOLOR}"
elif [[ -n $5 ]]; then
    echo -e "${COLOR_T[2]} Error: Enter only 4 arguments. Try again. ${ENDCOLOR}"
elif [[ $column1_background =~ $re && $column1_font_color =~ $re && $column2_background =~ $re && $column2_font_color =~ $re ]]; then
    value_output
    echo -e "\n"
    color_output
else 
    echo -e "${COLOR_T[2]} Error: Invalid argument entered. Try again. ${ENDCOLOR}"
fi
