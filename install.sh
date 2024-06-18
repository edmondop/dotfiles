#!/bin/bash

# Loop through each subdirectory in the current directory
for dir in */; do
    # Check if it's a directory
    if [ -d "$dir" ]; then
        # Remove the trailing slash
        dir=${dir%/}
        # Apply the stow command
        echo "Stowing $dir to $HOME..."
	stow "$dir" "$HOME"
    fi
done


# Ask Y/n
function ask() {
    read -p "$1 (Y/n): " resp
    if [ -z "$resp" ]; then
        response_lc="y" # empty is Yes
    else
        response_lc=$(echo "$resp" | tr '[:upper:]' '[:lower:]') # case insensitive
    fi

    [ "$response_lc" = "y" ]
}

SH="${HOME}/.bashrc"
ZSHRC="${HOME}/.zshrc"
if [ -f "$ZSHRC" ]; then
	SH="$ZSHRC"
fi

echo >> $SH
echo '# -------------- dotfiles install ---------------' >> $SH

# Ask which files should be sourced
echo "Do you want $SH to source: "
for file in zsh/shell/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
         if ! grep -Fxq "source $(realpath "$file")" "$SH"; then
                echo "source $(realpath "$file")" >> "$SH"
            else
                echo "$(realpath "$file") is already sourced in $SH"
            fi   fi
done
