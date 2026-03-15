# Source a file if it exists.
zsh_add_file() {
  [ -f "$1" ] && source "$1"
}

# Create a TMUX session using the current directory name.
ide() {
  local session
  session=$(basename "$PWD")

  if ! tmux has-session -t "$session" 2>/dev/null; then
    tmux new-session -s "$session" -n editor -d
    tmux send-keys -t "$session:1"
    tmux new-window -n terminal -t "$session"
    tmux select-window -t "$session:1"
  fi

  tmux attach -t "$session"
}
