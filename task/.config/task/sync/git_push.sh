#!/bin/bash

TASK_DIR="$HOME/.local/share/task"

if [ -d "$TASK_DIR/.git" ]; then
    cd "$TASK_DIR" || exit
    git push origin main --quiet
    echo "Pushed changes at $(date)" >>"$TASK_DIR/git_push.log"
else
    echo "Git repository not initialized in $TASK_DIR" >&2
    exit 1
fi
