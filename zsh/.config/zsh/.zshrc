source ~/.config/user-dirs.dirs

source "$ZDOTDIR/lib/functions.zsh"

zsh_add_file "$ZDOTDIR/conf.d/options.zsh"
zsh_add_file "$ZDOTDIR/conf.d/interactive.zsh"
zsh_add_file "$ZDOTDIR/conf.d/fzf.zsh"
zsh_add_file "$ZDOTDIR/conf.d/plugins.zsh"
zsh_add_file "$ZDOTDIR/conf.d/tools.zsh"
zsh_add_file "$ZDOTDIR/conf.d/completions.zsh"

zsh_add_file "$ZDOTDIR/aliases.zsh"
zsh_add_file "$ZDOTDIR/keybindings.zsh"
zsh_add_file "$HOME/Dropbox/dotfiles/secrets"
