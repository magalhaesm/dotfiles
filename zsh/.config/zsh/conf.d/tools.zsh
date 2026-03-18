if ! has_cmd asdf; then
  zsh_add_file "$HOME/.asdf/asdf.sh"
fi

if has_cmd zoxide; then
  eval "$(zoxide init --cmd j zsh)"
fi

zsh_add_file "$HOME/.opam/opam-init/init.zsh"

if has_cmd starship; then
  eval "$(starship init zsh)"
fi

zsh_add_file "$XDG_DATA_HOME/cargo/env"
