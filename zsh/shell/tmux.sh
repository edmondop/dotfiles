#!/bin/bash

export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

if [[ -S "$SSH_AUTH_SOCK" ]]; then
    export OLD_SOCK="${OLD_SOCK:-$SSH_AUTH_SOCK}" # Save the old sock if not already saved
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock  # Always update the symbolic link
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
