#!/usr/bin/env bash

day=$(date +%u)
if [ $day -eq 7 ]; then
	clear
	echo -e "\033[31mbin night\033[0m"
	read
fi

shutdown
