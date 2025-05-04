#!/bin/bash
# Add this to your .bashrc or .zshrc

copy() {
    # Check if it's macOS
    if [[ "$(uname)" == "Darwin" ]]; then
        # Use pbcopy on macOS
        pbcopy
    else
        # If on Linux, check if Wayland or X11 is in use
        if [ "$WAYLAND_DISPLAY" ]; then
            # Use wl-copy if running on Wayland
            wl-copy
        elif [ "$DISPLAY" ]; then
            # Use xclip if running on X11
            xclip -selection clipboard
        else
            if ! command -v it2copy &>/dev/null; then
                echo "Error: it2copy is not available ." >&2
                return 1
            fi
            # Use it2copy, assuming this is is an iTerm2 remote ssh session
            it2copy
        fi
    fi
}
