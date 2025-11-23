#!/bin/bash

BOOKMARK_FILE="$HOME/.local/bookmarks.txt"

while [[ $# -gt 0 ]]; do
	case $1 in
	--new)
		NEW_BOOKMARK=1
		shift
		;;
	--delete)
		DELETE_BOOKMARK=1
		shift
		;;
	*)
		echo "Unknown option: $1"
		echo "Usage: $0 [--new]"
		exit 1
		;;
	esac
done

if [[ $NEW_BOOKMARK -eq 1 ]]; then
	read -p "add url: " url
	echo "$url" >> "$BOOKMARK_FILE"
elif [[ $DELETE_BOOKMARK -eq 1 ]]; then
	url=$(cat "$BOOKMARK_FILE" | fzf)
	grep -vF "$url" "$BOOKMARK_FILE" > temp.txt \
		&& mv temp.txt "$BOOKMARK_FILE"
else
	# Select Bookmark
	if [[ ! -e "$BOOKMARK_FILE" ]]; then
		touch $BOOKMARK_FILE
	fi

	url=$(cat "$BOOKMARK_FILE" | fzf)
	xdg-open $url> /dev/null
fi

exit 0
