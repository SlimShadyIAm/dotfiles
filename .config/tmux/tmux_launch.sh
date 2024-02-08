#!/usr/bin/env zsh
# Thank you for this script @tale :)
# https://github.com/tale/dotfiles/blob/a9f150c1b851f39ae3efb93e1dda2d7a1592870f/config/tui/tmux_launch.sh

# Check if $d is set and is a directory
if [[ -z $d || ! -d $d ]]; then
	echo "Developer directory ($d) is not set correctly"
	exit 1
fi

# Add an option for raw folders
dirs=$(fd -d 2 -t d . $d)
dirs="- dotfiles\n$dirs"

# Open the fzf menu in the developer directory
dir=$(echo $dirs | fzf --ansi \
	--border none \
	--no-scrollbar \
	--preview-window border-left:40% \
	--preview "tmux list-sessions -F \"#{session_name} #{window_name} #{window_panes} #{window_active} #{window_flags}\" | \
		awk ' 
		BEGIN { 
			FS=\" \" 
			ORS=\"\" 
		} 
		{ 
			if (\$4 == 1) { 
				print \"\033[1;32m\" 
			} else { 
				print \"\033[0;37m\" 
			} 
			print \$1 
			print \"\033[0m\" 
			print \" - \" 
			print \$2 
			print \" (\" 
			print \$3
			print \")\n\" 
		}'")


if [[ -z $dir ]]; then
	exit 0
fi

# Custom session names
if [[ $dir == "- dotfiles" ]]; then
	session_name="main"
	dir="$DOTS"
else
	# Takes the directory and creates a session name from the last 2 parts
	session_dir_prefix=$(basename "$(dirname "$dir")" | sed 's/\./_/g')
	session_name="$session_dir_prefix-$(basename "$dir" | sed 's/\./_/g')"
fi

tmux_running="$(pgrep tmux)"

# Tmux is not running, start the session here
if [[ -z $tmux_running ]]; then
	tmux new-session -s "$session_name" -c "$dir"
	tmux attach -t "$session_name"
	exit 0
fi

# Create the session if it doesn't already exist
if ! tmux has-session -t "$session_name" 2>/dev/null; then
	tmux new-session -ds "$session_name" -c "$dir"
fi

# Attach to session if tmux client isn't running
if [[ -z $TMUX ]]; then
	tmux attach -t "$session_name"
	exit 0
fi

# Attach to session if tmux client is running
tmux switch-client -t "$session_name"

