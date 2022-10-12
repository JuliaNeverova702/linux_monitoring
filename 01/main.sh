#!/bin/bash

re='^[+-]?[0-9]+([.][0-9]+)?$'

if [[ -n "$1" && -z "$2" ]]; then
    if ! [[ $1 =~ $re ]]; then
        echo $1
    else
        echo "Invalid argument"
    fi
else 
echo "Enter one character"
fi