#!/bin/bash

set -e
if command -v bat &>/dev/null; then
	alias cat='bat'
elif command -v batcat &>/dev/null; then
	alias cat='batcat'
else
	alias cat='cat'
fi
