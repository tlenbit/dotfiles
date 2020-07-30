#!/bin/bash

# TODO
# - Map all 16 Midi channels to different instruments

timidity -iA -B2,8 \
	-Ei'49/1' \
	-Ei'1/2' \
	-Ei'3/3' \
	-Ei'4/4' \
	-Ei'5/5' \
	-Ei'6/6' \
	-Ei'7/7' \
	-Ei'8/8' \
	-Ei'9/9' \
	-Ei'10/10' \
	-Ei'11/11' \
	-Ei'12/12' \
	-Ei'13/13' \
	-Ei'14/14' \
	-Ei'15/15' \
	-Ei'16/16' \
	-Os </dev/null &>/dev/null &
sleep 0.3
aconnect 20:0 128:0