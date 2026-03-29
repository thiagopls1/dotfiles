#!/bin/bash

for f in *.mp4; do
  ffmpeg -sseof -30 -i "$f" -c copy "cut_$f"
done
