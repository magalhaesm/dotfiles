#!/usr/bin/env bash

# Author: Marcelo Magalhães
#
# Script to open files from the handbook directory in a new tmux window,
# and display file contents using 'bat' and 'less'

HANDBOOK="$(xdg-user-dir DOCUMENTS)/handbook/"

tmux-window() {
  tmux new-window -n "$(basename "$0" .sh)" "$SHELL" -c "$1"
}

open_handbook() {
  local selected

  selected=$(find "$HANDBOOK" -maxdepth 1 -type f \
    ! \( -name "README.md" -o -name "LICENSE" \) |\
    fzf -e -i --delimiter '/' --with-nth '-1' --prompt="Handbook: ")

  echo "$selected"
}

main() {
  selected=$(open_handbook)

  if [ -n "$selected" ]; then
    tmux-window "bat $selected -l sh | less"
  fi
}

main
