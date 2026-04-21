#!/bin/bash

# Clear cached color screenshots while preserving provided file paths.
# Args:
#   1: cache directory path
#   2..n: screenshot file paths to keep

cache_dir="$1"
shift

mkdir -p "$cache_dir"

for item in "$cache_dir"/*; do
  [ -e "$item" ] || continue

  keep=0
  for preserved in "$@"; do
    if [ "$item" = "$preserved" ]; then
      keep=1
      break
    fi
  done

  if [ "$keep" -eq 0 ]; then
    rm -rf "$item"
  fi
done
