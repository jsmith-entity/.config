#!/bin/bash

TODO_FOLDER=".todo"

function create_task() {
	local file=$1
	local task_name=$2

	cat <<-EOF > $file 
	# $task_name

	- STATUS: OPEN
	- PRIORITY: 0
	- TAGS: 
	EOF
}

while [[ $# -gt 0 ]]; do
	case $1 in
	--open)
		OPEN_TASK=1
		shift
		;;
	--new)
		NEW_TASK=1
		shift
		;;
	*)
		echo "Unknown option: $1"
		echo "Usage: $0 [--new]"
		exit 1
		;;
	esac
done

mkdir -p "$TODO_FOLDER"

if [[ $OPEN_TASK -eq 1 ]]; then
	entires=()

	# Collect task entries
	for task in "$TODO_FOLDER"/*; do
		file="$task/task.md"
		task_name=$(head -n 1 $file)
		priority=$(grep -m 1 '^- PRIORITY:' "$file" | awk -F': ' '{print $2}')
		priority=$(printf "[PRIORITY: %02d]" "$priority")
		tags=$(grep -m 1 '^- TAGS:' "$file" | awk -F': ' '{print $2}')
		tags=$(printf "[TAGS: %s]" "$tags")
		entries+=("$(basename $task) $priority $tags $task_name")
	done 

	# Select todo task
	selected_task=$(printf "%s\n" "${entries[@]}" \
		| sort -k2,2nr \
		| fzf --reverse \
		| awk '{print $1}')

	if [ -z "$selected_task" ]; then
		exit 1
	else
		selected_task="$selected_task/task.md"
	fi

	file_location="$PWD/$TODO_FOLDER/$selected_task"
	nvim $file_location
elif [[ $NEW_TASK -eq 1 ]]; then
	read -p "task name: " task_name

	curr_date=$(date +%Y%m%d)

	# Find current task number
	if compgen -G "$TODO_FOLDER/*-*" > /dev/null; then
		curr_task_num=$(basename -a $TODO_FOLDER/*-* \
			| awk -F'-' '{print $2}' \
			| sort -n \
			| tail -n 1)
	else
		curr_task_num=0
	fi

	next_task_num=$(printf "%04d" $((10#$curr_task_num + 1)))

	task_dir="$TODO_FOLDER/$curr_date-$next_task_num"
	task_file="$task_dir/task.md"

	mkdir -p $task_dir
	create_task $task_file "$task_name"

	nvim $task_file
fi
