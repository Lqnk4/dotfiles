#!/bin/sh

# Use this for FCITX5
INPUT="$(fcitx5-remote -n)"

if [[ "$INPUT" == "keyboard-us" ]]; then
    echo "US"
elif [[ "$INPUT" == "mozc" ]]; then
    echo "日本語"
elif [[ "$INPUT" == "" ]]; then
    echo "NONE"
fi
