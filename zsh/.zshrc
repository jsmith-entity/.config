autoload -U colors && colors
bindkey -e

PS1="%{$fg[blue]%}%~%{$fg[red]%} %{$reset_color%}$%b "

source <(fzf --zsh)

alias c="clear;ls -A"

# Update git status
source ~/.config/scripts/git-status.sh
if [[ -z "${precmd_functions[(r)tmux_update_git_status]}" ]]; then
  precmd_functions+=(tmux_update_git_status)
fi
