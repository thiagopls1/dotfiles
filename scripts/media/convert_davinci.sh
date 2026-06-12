#!/bin/bash

if [ $# -ne 1 ] || [ $# -ne 2]; then
	echo "Usage: $0 /path/to/folder /destination/path (optional)" 
    exit 1
fi

input_folder="$1"
output_folder="$input_folder/Converted"

if [ -n "$2" ]; then
	output_folder="$2"
fi


if [ ! -d "$output_folder" ]; then
    mkdir "$output_folder"
fi

for video_file in "$input_folder"/*.mp4; do
    if [ -f "$video_file" ]; then
        filename=$(basename "$video_file")
        output_file="$output_folder/${filename%.mp4}.mov"
        
        ffmpeg -i "$video_file" -c:v dnxhd -profile:v dnxhr_hq -pix_fmt yuv422p -acodec pcm_s16le -f mov "$output_file"
        
        echo "Converted: $filename -> ${filename%.mp4}.mov"
    fi
done

echo "Conversion completed."
