fpath=(
  "$HOME/.asdf/internal/completions"
  "$HOME/.oh-my-zsh/custom/completions"
  $fpath
)

autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME}/zsh/.zcompdump"
