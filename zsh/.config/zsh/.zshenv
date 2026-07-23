typeset -U PATH path

export PATH="$PATH:$HOME/.local/bin"

# === XDG Dirs ===
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}

if [ "$(uname -s)" = "Darwin" ] && ! command -v brew >/dev/null 2>&1; then
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

# === Zsh ===
export ZSH="${XDG_CONFIG_HOME}/oh-my-zsh"

# === System ===
export EDITOR="nvim"
export TERMINAL="kitty"
export COLORTERM="truecolor"

# Go environment
export GOPATH=$HOME/.local/go
export PATH="$PATH:$GOPATH/bin"

export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export PATH="$PATH:$CARGO_HOME/bin"

export NVM_DIR="$HOME/.config/nvm"
if [ -d "$NVM_DIR/versions/node/v22.14.0/bin" ]; then
  export PATH="$NVM_DIR/versions/node/v22.14.0/bin:$PATH"
fi
