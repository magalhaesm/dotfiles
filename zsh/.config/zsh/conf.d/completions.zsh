if [ -d "$HOME/.asdf/internal/completions" ]; then
  fpath=("$HOME/.asdf/internal/completions" $fpath)
fi

if [ -d "$HOME/.oh-my-zsh/custom/completions" ]; then
  fpath=("$HOME/.oh-my-zsh/custom/completions" $fpath)
fi

autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME}/zsh/.zcompdump"
