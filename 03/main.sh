#!/bin/bash

. ./set_color
. ./../common/output

sudo ln -sf /../../../../usr/share/zoneinfo/Asia/Novosibirsk /etc/localtime

re='^[1-6]$'

if [[ $1 == $2 || $3 == $4 ]]; then
    echo -e "${COLOR_T[2]} Error: Enter difference color. Try again. ${ENDCOLOR}"
elif [[ -n $5 ]]; then
    echo -e "${COLOR_T[2]} Error: Enter only 4 arguments. Try again. ${ENDCOLOR}"
elif [[ $1 =~ $re && $2 =~ $re && $3 =~ $re && $4 =~ $re ]]; then
    value_output
else 
    echo -e "${COLOR_T[2]} Error: Invalid argument entered. Try again. ${ENDCOLOR}"
fi
