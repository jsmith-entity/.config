#!/usr/bin/env bash

session_created=$(tmux display-message -p "#{session_created}" 2>/dev/null)
now=$(date +%s)
elapsed=$((now-session_created))

h=$((elapsed/3600))
m=$((elapsed%3600/60))
s=$((elapsed%60))

printf "%02d:%02d:%02d" "$h" "$m" "$s"
