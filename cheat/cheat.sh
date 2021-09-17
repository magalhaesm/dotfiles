#!/usr/bin/env bash

list() {
  arr=("$@")
  echo "${arr[*]}" | tr ' ' '\n'
}

tmux-window() {
  tmux new-window -n info "$SHELL" -c "$1 | less -R"
}

utils=("xargs" "find" "sed" "awk" "fd" "tar" "tr")
languages=("c" "cpp" "bash" "lua" "rust" "golang" "python" "javascript" "typescript")

all=("${languages[@]}" "${utils[@]}")
selected=$(list "${all[@]}" | fzf)

read -p "Enter query: " -r query

if grep -qw "$selected" <<< "${all[@]}"
then
  tmux-window "curl -s cht.sh/$selected/$(echo "$query" | tr ' ' '+')"
else
  tmux-window "curl -s cht.sh/$selected/~$query"
fi
