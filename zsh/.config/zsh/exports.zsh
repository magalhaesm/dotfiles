# Define as variáveis de ambiente

# ESTE ARQUIVO É CARREGADO NO LOGIN POR /etc/zsh/zshenv

typeset -U PATH path

export PATH="$PATH:$HOME/.local/bin"

# -- Diretórios XDG ------------------------------------------------------------

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}

# -- Zsh -----------------------------------------------------------------------

export KEYTIMEOUT=1
export ZSH="${XDG_CONFIG_HOME}/oh-my-zsh"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# -- Sistema -------------------------------------------------------------------

export EDITOR="nvim"
export TERMINAL="kitty"
export COLORTERM="truecolor"
export BROWSER="brave"

export HISTSIZE=30000
export HISTFILE="${XDG_CACHE_HOME}/history"

# -- Fzf -----------------------------------------------------------------------

export FZF_DEFAULT_COMMAND="fd --type f --exclude '*.o'"
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS}
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
export FZF_ALT_C_OPTS="--border --preview 'tree -L 1 -C --dirsfirst {} | head -200'"

export FZF_CTRL_R_OPTS="--height 40%"

export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_CTRL_T_OPTS="--border --preview ${FZF_BAT_PREVIEW}"

# -- Less -----------------------------------------------------------------------

export LESSHISTFILE="-"
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# -- Rustup --------------------------------------------------------------------

export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

# -- ASDF ----------------------------------------------------------------------

export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdfrc"
export ASDF_DIR="/opt/asdf-vm"
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"

# -- Misc ----------------------------------------------------------------------

# Armazena credenciais de login automático para serviços de rede
export NETRC="${XDG_CONFIG_HOME}/netrc"

export BAT_PAGER="less"
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"
export SQLITE_HISTORY="${XDG_CACHE_HOME}/sqlite_history"

export TMUX_CONFIG="${XDG_CONFIG_HOME}/tmux/tmux.conf"
export TMUX_TMPDIR="${XDG_RUNTIME_DIR}"

export NODE_REPL_HISTORY="${XDG_DATA_HOME}/node_repl_history"
export NPM_CONFIG_USERCONFIG="~/.config/npm/npmrc"

export IPYTHONDIR="${XDG_CONFIG_HOME}/jupyter"
export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"
export PYLINTHOME="${XDG_CACHE_HOME}/pylint"

export GOPATH="${XDG_DATA_HOME}/go"

export _ZO_DATA_DIR="${XDG_DATA_HOME}/zoxide"

export GNUPGHOME="${XDG_DATA_HOME}"
