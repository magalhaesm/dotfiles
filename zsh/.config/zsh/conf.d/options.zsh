setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent

setopt interactive_comments
setopt extended_glob
setopt no_beep

setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_save_no_dups
setopt hist_reduce_blanks
setopt share_history
setopt append_history

setopt complete_in_word
setopt always_to_end

autoload -Uz colors
colors
