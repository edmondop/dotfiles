#!/bin/bash
alias glp='git log --pretty=format:"%C(yellow)%h%Creset - %C(green)%an%Creset, %ar : %s"'
alias ls=colorls
alias vim=nvim
if which batcat >/dev/null 2>&1; then
    alias cat=batcat
elif which bat >/dev/null 2>&1; then
    alias cat=bat
fi
