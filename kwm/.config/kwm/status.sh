#!/bin/sh

fifo="${XDG_RUNTIME_DIR}/kwm-status.fifo"

rm -f "$fifo"
mkfifo "$fifo"

trap 'rm -f "$fifo"' EXIT INT TERM

while :; do
    time=$(date '+%a %d %b %H:%M')
    printf '%s' "$time" > "$fifo"
    sleep 1
done
