#!/bin/bash

pid=$(pgrep -x waybar)
if [ -n "$pid" ]; then
	kill "$pid"
else
	waybar > /dev/null 2>&1 < /dev/null &
fi
