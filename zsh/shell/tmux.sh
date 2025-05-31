#!/bin/bash

export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

if [[ "$(uname -s)" == "Linux" && "$(lsb_release -is 2>/dev/null)" == "Ubuntu" && "$(hostname)" == "devrestricted-eporcu" ]]; then

    if [[ -S "$SSH_AUTH_SOCK" ]]; then
        export OLD_SOCK="${OLD_SOCK:-$SSH_AUTH_SOCK}" # Save the old sock if not already saved
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock  # Always update the symbolic link
    fi
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
fi

Linux devrestricted-eporcu 6.8.0-1026-aws #28-Ubuntu SMP Mon Mar 24 19:32:19 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
