plugins=(
  asdf
  zsh-autosuggestions
  fast-syntax-highlighting
)

zsh_add_file "$ZSH/oh-my-zsh.sh"

bindkey "^ " autosuggest-accept
