# Define as variáveis de ambiente

# ESTE ARQUIVO É CARREGADO NO LOGIN POR /etc/zsh/zshenv

typeset -U PATH path

export PATH="$PATH:$HOME/.local/bin"

# -- Diretórios XDG ------------------------------------------------------------

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}

# -- Zsh -----------------------------------------------------------------------

export ZSH="${XDG_CONFIG_HOME}/oh-my-zsh"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# -- Sistema -------------------------------------------------------------------

export EDITOR="nvim"
export TERMINAL="kitty"
export TERMINAL_THEME="dracula"
export BROWSER="vivaldi"
export TERM="xterm-256color"
export COLORTERM="truecolor"

export HISTSIZE=30000
export SAVEHIST=10000
export HISTFILE="${XDG_CACHE_HOME}/zsh/history"

# -- Fd ------------------------------------------------------------------------

export FD_COMMAND="fd"
export FD_OPTIONS="--follow --exclude .git --exclude node_modules"

# -- Fzf -----------------------------------------------------------------------

export FZF_DEFAULT_COMMAND="${FD_COMMAND} --type f"
export FZF_DEFAULT_OPTS=${FZF_DEFAULT_OPTS}'
--color=dark
--color=fg:-1,bg:-1,hl:#bd93f9,fg+:#f8f8f2,bg+:-1,hl+:#bd93f9
--color=info:#50fa7b,prompt:#61afef,pointer:#ff5555,marker:#ffb86c,spinner:#61afef,header:#61afef
--height 100% --layout=reverse --border --cycle --info=inline
'

export FZF_ALT_C_COMMAND="${FD_COMMAND} --type d"
export FZF_ALT_C_OPTS="--preview 'tree -L 1 -C --dirsfirst {} | head -200'"

export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"

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

# -- Misc ----------------------------------------------------------------------

export BAT_PAGER="less"
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"
export SQLITE_HISTORY="${XDG_CACHE_HOME}/sqlite_history"

export TMUX_CONFIG="${XDG_CONFIG_HOME}/tmux/tmux.conf"
export TMUX_TMPDIR="${XDG_RUNTIME_DIR}"

export TASKRC="${XDG_CONFIG_HOME}/taskrc"
export TASKDATA="${XDG_DATA_HOME}/task"

export NODE_REPL_HISTORY="${XDG_DATA_HOME}/node_repl_history"
export NPM_CONFIG_USERCONFIG="~/.config/npm/npmrc"

export IPYTHONDIR="${XDG_CONFIG_HOME}/jupyter"
export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"
export PYLINTHOME="${XDG_CACHE_HOME}/pylint"

export GOPATH="${XDG_DATA_HOME}/go"

export _ZO_DATA_DIR="${XDG_DATA_HOME}/zoxide"

export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
