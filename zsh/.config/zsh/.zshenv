typeset -U PATH path

export PATH="$PATH:$HOME/.local/bin"

# === XDG Dirs ===
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}

# === Zsh ===
export ZSH="${XDG_CONFIG_HOME}/oh-my-zsh"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# === System ===
export EDITOR="nvim"
export TERMINAL="kitty"
export COLORTERM="truecolor"

# Go environment
export GOROOT=/usr/local/go
export GOPATH=$HOME/.local/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export PATH="$PATH:$CARGO_HOME/bin"

export NVM_DIR="$HOME/.config/nvm"
export PATH="$NVM_DIR/versions/node/v22.14.0/bin:$PATH"
