#!/bin/bash

REMOTE_NAME=gdrive
FOLDERS=(Pictures Videos Documents Public)

for FOLDER in "${FOLDERS[@]}"; do
	echo "Synchronizing $FOLDER..."
	
	if [[ -f "$HOME/$FOLDER/.rcloneignore" ]]; then
		rclone sync $HOME/$FOLDER $REMOTE_NAME:$FOLDER -P --exclude-from $HOME/$FOLDER/.rcloneignore --verbose
	else
		rclone sync $HOME/$FOLDER $REMOTE_NAME:$FOLDER -P --verbose
	fi

done
