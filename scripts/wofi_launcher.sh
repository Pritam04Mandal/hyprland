#!/bin/bash

# Check if wofi is already running
if pgrep -x "wofi" >/dev/null; then
	# If it's running, kill it
	pkill -x wofi
else
	# If it's not running, open it
	wofi --show drun &
fi
