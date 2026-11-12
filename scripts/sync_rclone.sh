#!/bin/bash

set -euo pipefail

REMOTE_NAME="gdrive"
FOLDERS=(Pictures Videos Documents Public)

for FOLDER in "${FOLDERS[@]}"; do
    LOCAL_PATH="$HOME/$FOLDER"
    REMOTE_PATH="$REMOTE_NAME:$FOLDER"
    IGNORE_FILE="$LOCAL_PATH/.rcloneignore"

    echo "Synchronizing $FOLDER..."

    RCLONE_ARGS=(
        bisync
        "$LOCAL_PATH"
        "$REMOTE_PATH"
        -P
        --verbose
        --resilient
        --recover
        --conflict-resolve
        none
    )

    if [[ -f "$IGNORE_FILE" ]]; then
        RCLONE_ARGS+=(--exclude-from "$IGNORE_FILE")
    fi

    rclone "${RCLONE_ARGS[@]}"
done

