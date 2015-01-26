#!/bin/bash
# linkeld a ~/.kde/Autostart könyvtárba

loop_timeout=8
color="orange"
font="-b&h-lucida-bold-i-normal-*-26-*-*-*-*-*-*-*"

function osd_text()
{
#$1 msg
#$2 pos
#$3 align
  /bin/echo -e "$1" | \
  DISPLAY=:0 \
  /usr/bin/osd_cat \
        --font="${font}" \
        --color=${color} \
        --pos="$2" \
        --align="$3" \
        --offset=50 \
        --indent=20 \
        --shadow=2 \
        --delay=${loop_timeout}
}

function run_if_not_runs_yet()
{
  if [ -z `pgrep "$1"` ]
  then
    "$1" &
  fi
}

#enable On Screen Display for nut
xhost +local:nut
osd_text "On Screen Display enabled for\nNetwork UPS Tools!" "top" "center"

run_if_not_runs_yet klipper
run_if_not_runs_yet  conky
run_if_not_runs_yet yakuake

logger -t `basename $0` " skript ended."
