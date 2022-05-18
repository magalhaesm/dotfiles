#!/usr/bin/env bash
#
# Inside Tmux, run cheat.sh queries
# Trigger on tmux config
#
# Inspired by Primeagen
# source: https://www.youtube.com/watch?v=hJzqEAf2U4I

languages="$HOME/.config/tmux/cheat/languages.txt"
commands="$HOME/.config/tmux/cheat/commands.txt"
pages="$HOME/.config/tmux/cheat/pages.txt"

tmux-window() {
  tmux new-window -n "$(basename "$0")" "$SHELL" -c "$1 | less -R"
}

get_query() {
  read -p "Enter query: " -r query
  echo "$query" | tr ' ' '+'
}

is_tool() {
  ! grep -qw "$pages" -e "$1"
}

selected=$(cat "$languages" "$commands" "$pages" | fzf --prompt="cheat.sh: ")

if is_tool "$selected"; then
  tmux-window "curl -s cht.sh/$selected/$(get_query)"
elif [ -n "$selected"  ]; then
  tmux-window "curl -s cht.sh/$selected"
fi
