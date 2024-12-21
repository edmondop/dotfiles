#!/bin/bash
set -e
# Add this to your .bashrc or .zshrc

copy() {
	# Check if it's macOS
	if [[ "$(uname)" == "Darwin" ]]; then
		# Use pbcopy on macOS
		pbcopy
	else
		# If on Linux, check if Wayland or X11 is in use
		if [ "$WAYLAND_DISPLAY" ]; then
			# Use wl-copy if running on Wayland
			wl-copy
		elif [ "$DISPLAY" ]; then
			# Use xclip if running on X11
			xclip -selection clipboard
		else
			echo "No display server detected. Could not determine clipboard tool." >&2
			return 1
		fi
	fi
}

# Example usage:
# cat file | copy
