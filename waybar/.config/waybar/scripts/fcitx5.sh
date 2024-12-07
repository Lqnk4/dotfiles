#!/bin/sh

# Use this for FCITX5
INPUT="$(fcitx5-remote -n)"

if [[ "$INPUT" == "keyboard-us" ]]; then
    echo "English (US)"
elif [[ "$INPUT" == "mozc" ]]; then
    echo "Japanese (日本語)"
elif [[ "$INPUT" == "" ]]; then
    echo "No Layout"
fi
