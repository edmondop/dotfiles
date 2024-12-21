#!/bin/bash
set -e
# Set GoEnv root directory
export GOENV_ROOT="$HOME/.goenv"

# Add GoEnv to PATH
export PATH="$GOENV_ROOT/bin:$PATH"

# Initialize GoEnv
eval "$(goenv init -)"

# Set GOROOT and GOPATH
export GOROOT="$(go env GOROOT)"
export GOPATH="$HOME/go"

# Add GOROOT and GOPATH to PATH
export PATH="$GOROOT/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
