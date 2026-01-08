#!/bin/bash

REMOTE_NAME=gdrive
FOLDERS=(Pictures Videos Documents Public)

for FOLDER in "${FOLDERS[@]}"; do
	echo "Synchronizing $FOLDER..."
	rclone sync $HOME/$FOLDER $REMOTE_NAME:$FOLDER -P
done
