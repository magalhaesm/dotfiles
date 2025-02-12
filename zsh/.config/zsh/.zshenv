typeset -U PATH path

export PATH="$PATH:$HOME/.local/bin"

# === XDG Dirs ===
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}

# === Zsh ===
export KEYTIMEOUT=1
export ZSH="${XDG_CONFIG_HOME}/oh-my-zsh"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# === System ===
export EDITOR="nvim"
export TERMINAL="kitty"
export COLORTERM="truecolor"

export HISTSIZE=30000
export HISTFILE="${XDG_CACHE_HOME}/history"

# === Fzf ===
export FZF_DEFAULT_COMMAND="fd --type f --exclude '*.o'"
export FZF_DEFAULT_OPTS="
  --color=dark
  --color=fg:-1,bg:-1,hl:#ae81ff,fg+:#f8f8f0,bg+:-1,hl+:#ae81ff
  --color=info:#a6e22e,prompt:#66d9ef,pointer:#e95678
  --color=marker:#fd971f,spinner:#66d9ef,header:#66d9ef
  --height 100% --layout=reverse --no-border --cycle --info=inline
  --bind=ctrl-d:preview-page-down
  --bind=ctrl-u:preview-page-up
"
export FZF_BAT_PREVIEW="'bat --style=numbers --color=always --line-range :500 {}'"
export FZF_COMPLETION_OPTS="--border"

export FZF_ALT_C_COMMAND="fd --type d"
export FZF_ALT_C_OPTS="--border --preview 'eza -T -L2 {} | head -200'"

export FZF_CTRL_R_OPTS="--height 40%"

export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_CTRL_T_OPTS="--border --preview ${FZF_BAT_PREVIEW}"

# === Less ===
export PAGER="less"
export LESSHISTFILE="-"

export LESS_TERMCAP_mb=$'\e[1;32m'   # Negrito verde
export LESS_TERMCAP_md=$'\e[1;32m'   # Negrito verde
export LESS_TERMCAP_me=$'\e[0m'      # Reset de formatação
export LESS_TERMCAP_so=$'\e[01;33m'  # Negrito amarelo
export LESS_TERMCAP_se=$'\e[0m'      # Reset de formatação
export LESS_TERMCAP_us=$'\e[1;4;31m' # Negrito, sublinhado, vermelho
export LESS_TERMCAP_ue=$'\e[0m'      # Reset de formatação

export GROFF_NO_SGR=1   # Desabilita SGR (Select Graphic Rendition)

# === ASDF ===
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdfrc"
export ASDF_DIR="/opt/asdf-vm"
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"

# === Misc ===
export BAT_PAGER="less"
export TMUX_CONFIG="${XDG_CONFIG_HOME}/tmux/tmux.conf"
export _ZO_DATA_DIR="${XDG_DATA_HOME}/zoxide"

export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"

export PATH="$PATH:$HOME/.local/share/asdf/installs/golang/1.22.5/packages/bin"
