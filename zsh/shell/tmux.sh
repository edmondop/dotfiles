#!/bin/bash

export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

if test "$SSH_AUTH_SOCK"; then
    if test -z "$TMUX"; then
        if [[ $TERM_PROGRAM != "vscode" ]]; then
            echo 'Linking ~/.ssh/ssh_auth_sock to $SSH_AUTH_SOCK'
            ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
        fi
    fi
fi
