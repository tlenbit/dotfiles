#!/bin/bash

# First storing temporarily the text content into a file
TMP_FILE=/tmp/text-for-reading.txt

xclip -o > $TMP_FILE

# Then read it
fltrdr $TMP_FILE