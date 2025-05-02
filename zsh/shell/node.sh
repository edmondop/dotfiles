#!/bin/bash
# export PATH="$HOME/.nodenv/bin:$PATH"
# eval "$(nodenv init -)"
# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env)"
fi

export PNPM_HOME="/home/eporcu/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
