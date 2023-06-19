#!/usr/bin/env bash

# Get the directory of the script
DIR="${0%/*}"

FILE_LIST=$(find "$DIR" -maxdepth 1 -type f -exec basename {} \; |\
  sort | grep '^_' | sed 's@\.@ @g' | column -s ',' -t)

SELECTED=$(echo "$FILE_LIST" | fzf -e -i --delimiter _ --with-nth='2..' \
  --prompt="fzf-speed: " --info=default --layout=reverse --tiebreak=index |\
  cut -d ' ' -f1)

# Execute the selected file
eval "${DIR}/${SELECTED},*"
