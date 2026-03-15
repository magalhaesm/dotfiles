zsh_add_file "$HOME/.asdf/asdf.sh"

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init --cmd j zsh)"
fi

zsh_add_file "$HOME/.opam/opam-init/init.zsh"

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

zsh_add_file "$XDG_DATA_HOME/cargo/env"
