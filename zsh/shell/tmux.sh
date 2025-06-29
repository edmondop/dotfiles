#!/bin/bash

export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

update_symlink_and_export() {
    local socket="$1"
    ln -sf "$socket" ~/.ssh/ssh_auth_sock
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
    echo "Updated SSH_AUTH_SOCK symlink to ${SSH_AUTH_SOCK}"
}

fix_ssh_agent_forwarding() {
    ssh-add -l 1>/dev/null 2>/dev/null
    if [[ "$?" != "0" ]]; then
        local socket=$(find /tmp/ssh-**/agent.* | head -n1)
        echo "SSH agent socket found: $socket"
        update_symlink_and_export "$socket"
    fi
}

update_socket_symlink() {
    if [[ "$SSH_AUTH_SOCK" != "$HOME/.ssh/ssh_auth_sock" ]]; then
        if [[ -S "$SSH_AUTH_SOCK" ]]; then
            update_symlink_and_export "$SSH_AUTH_SOCK"
        else
            echo "SSH_AUTH_SOCK is not a valid socket: $SSH_AUTH_SOCK"
        fi
    else
        echo "SSH_AUTH_SOCK already points to the symlink: $SSH_AUTH_SOCK"
    fi
}

if [[ "$(uname -s)" == "Linux" && "$(lsb_release -is 2>/dev/null)" == "Ubuntu" && "$(hostname)" == "devrestricted-eporcu" ]]; then
    update_socket_symlink
fi
