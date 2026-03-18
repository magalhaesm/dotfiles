# Source a file if it exists.
zsh_add_file() {
  [ -f "$1" ] && source "$1"
}

has_cmd() {
  command -v "$1" >/dev/null 2>&1
}

zsh_alias_if_cmd() {
  local name=$1
  local cmd=$2
  shift 2
  local target="$*"

  if [[ "${DOTFILES_LEGACY_OPTIONALS:-0}" = "1" ]] || has_cmd "$cmd"; then
    alias "$name=$target"
  fi
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
