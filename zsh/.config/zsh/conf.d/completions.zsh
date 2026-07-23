if [ -d "$HOME/.asdf/internal/completions" ]; then
  fpath=("$HOME/.asdf/internal/completions" $fpath)
fi

if [ -d "$ZSH/custom/completions" ]; then
  fpath=("$ZSH/custom/completions" $fpath)
fi

autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME}/zsh/.zcompdump"
