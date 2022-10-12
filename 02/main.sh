#!/bin/bash

. ./set_value
. ./writing_to_file

sudo ln -sf /../../../../usr/share/zoneinfo/Asia/Novosibirsk /etc/localtime

set_value
writing_to_file
