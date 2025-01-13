#!/bin/bash

SYSTEMD_DIR="/etc/systemd/system"
SOURCE_DIR="$(pwd)"

SERVICE_FILE="taskwarrior_git_push.service"
TIMER_FILE="taskwarrior_git_push.timer"

# Function to copy files
install_file() {
    local src="$1"
    local dest="$2"

    if [[ -f "$src" ]]; then
        echo "Copying $src to $dest"
        sudo cp "$src" "$dest"
    else
        echo "Error: $src not found!"
        exit 1
    fi
}

install_file "$SOURCE_DIR/$SERVICE_FILE" "$SYSTEMD_DIR/$SERVICE_FILE"
install_file "$SOURCE_DIR/$TIMER_FILE" "$SYSTEMD_DIR/$TIMER_FILE"

echo "Reloading systemd..."
sudo systemctl daemon-reload

echo "Enabling and starting the timer..."
sudo systemctl enable "$TIMER_FILE"
sudo systemctl start "$TIMER_FILE"

echo "Checking the timer status..."
systemctl list-timers | grep "$(basename "$TIMER_FILE")"

echo "Installation complete!"
