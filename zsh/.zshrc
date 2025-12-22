autoload -U colors && colors
bindkey -e
PS1="$(((SHLVL>2))&&echo '%{$fg[blue]%}[nix]') %{$fg[blue]%}%~%{$fg[red]%} %{$reset_color%}$%b "

source <(fzf --zsh)

c() {
	case "$PWD" in
	"$HOME" || \
	"/home/shared" || "/home/shared/.config" || \
	$(git rev-parse --is-inside-work-tree &>/dev/null && echo 1))
		clear
		LC_ALL=C ls -A --group-directories-first
		;;
	*)
		clear
		LC_ALL=C ls --group-directories-first
		;;
	esac
}

# Update git status
source ~/.config/scripts/git-status.sh
if [[ -z "${precmd_functions[(r)tmux_update_git_status]}" ]]; then
  precmd_functions+=(tmux_update_git_status)
fi
