# === Functions ===

# Source a file if it exists
zsh_add_file() {
  [ -f "$1" ] && source "$1"
}

# Create a TMUX session using the current directory's name as the session name.
# The session will have two windows: "editor" and "terminal".
# The "editor" window opens with the default command defined by the $EDITOR
# environment variable.
ide() {
  SESSION=$(basename "$PWD")
  if ! tmux has-session -t "$SESSION" 2>/dev/null
  then
    # tmux -f "$TMUX_CONFIG" new-session -s "$SESSION" -n editor -d "$EDITOR"
    # tmux -f "$TMUX_CONFIG" new-session -s "$SESSION" -n editor -d
    tmux new-session -s "$SESSION" -n editor -d
    # tmux send-keys -t "$SESSION:1" "$EDITOR" C-m
    tmux send-keys -t "$SESSION:1"
    tmux new-window -n terminal -t "$SESSION"
    tmux select-window -t "$SESSION:1"
  fi
  tmux attach -t "$SESSION"
}

# === Oh-My-Zsh ===
# ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  zsh-autosuggestions
  fast-syntax-highlighting
)

zsh_add_file "$ZSH/oh-my-zsh.sh"

# === Plugin Preferences ===
# zsh-autosuggestions
bindkey "^ " autosuggest-accept

# === Personal Preferences ===
zsh_add_file "$ZDOTDIR/aliases.zsh"
zsh_add_file "$ZDOTDIR/keybindings.zsh"
zsh_add_file "$HOME/Dropbox/dotfiles/secrets"

# === Tools ===

# Fzf
zsh_add_file "$XDG_CONFIG_HOME/fzf/fzf.zsh"

# ASDF
zsh_add_file "/opt/asdf-vm/asdf.sh"
zsh_add_file "$XDG_DATA_HOME/asdf/plugins/golang/set-env.zsh"
export PATH="$PATH:$GOPATH/bin"

# Zoxide
eval "$(zoxide init --cmd j zsh)"

zsh_add_file "$HOME/.opam/opam-init/init.zsh"

eval "$(starship init zsh)"

zsh_add_file "$XDG_DATA_HOME/cargo/env"
