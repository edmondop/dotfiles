#!/bin/bash
# Add this to your .bashrc or .zshrc

# copy() {
#     # Check if it's macOS
#     if [[ "$(uname)" == "Darwin" ]]; then
#         # Use pbcopy on macOS
#         pbcopy
#     else
#         # If on Linux, check if Wayland or X11 is in use
#         if [ "$WAYLAND_DISPLAY" ]; then
#             # Use wl-copy if running on Wayland
#             wl-copy
#         elif [ "$DISPLAY" ]; then
#             # Use xclip if running on X11
#             xclip -selection clipboard
#         else
#             it2copy || {
#                 echo "Error: it2copy is not working or not available." >&2
#                 return 1
#             }
#         fi
#     fi
# }
copy() {
    local input
    input=$(cat)

    if [[ "$(uname)" == "Darwin" ]]; then
        # macOS
        printf "%s" "$input" | pbcopy
    elif [[ -n "$WAYLAND_DISPLAY" ]] && command -v wl-copy >/dev/null 2>&1; then
        # Wayland
        printf "%s" "$input" | wl-copy
    elif [[ -n "$DISPLAY" ]] && command -v xclip >/dev/null 2>&1; then
        # X11
        printf "%s" "$input" | xclip -selection clipboard
    elif [[ -n "$TMUX" ]]; then
        # Inside tmux, use OSC52
        local base64_data
        base64_data=$(printf "%s" "$input" | base64 | tr -d '\n')
        printf "\e]52;c;%s\a" "$base64_data" > "$(tmux display-message -p '#{client_tty}')"
    else
        # Fallback to OSC52
        local base64_data
        base64_data=$(printf "%s" "$input" | base64 | tr -d '\n')
        printf "\e]52;c;%s\a" "$base64_data"
    fi
}
