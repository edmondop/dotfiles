#!/bin/bash

set -e
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"
