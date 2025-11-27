#!/usr/bin/env bash

function tmux_update_git_status() {
	branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null) || true
	if [[ -n $branch ]]; then
		if [[ -n $(git status --porcelain 2> /dev/null) ]]; then
			tmux set -g status-left "#S#[fg=cyan]::${branch}*#[default]"
		else
			tmux set -g status-left "#S#[fg=cyan]::${branch}#[default]"
		fi
	else
		tmux set -g status-left "#S"
	fi
}
