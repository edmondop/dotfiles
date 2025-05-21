#!/bin/bash

# Loop through all directories in the current directory (dotfile packages)
for dir in */; do
    # Check if it's a directory
    if [ -d "$dir" ]; then
        # Remove the trailing slash for the stow command
        dir=${dir%/}
        echo "Unstowing $dir from $HOME..."
        stow -D "$dir" -t "$HOME"
    fi
done
