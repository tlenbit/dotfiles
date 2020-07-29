#!/bin/bash
timidity -iA -B2,8 -Os </dev/null &>/dev/null &
sleep 0.1
aconnect 20:0 128:0