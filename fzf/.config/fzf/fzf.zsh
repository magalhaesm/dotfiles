# Setup fzf
# ---------
# if [[ ! "$PATH" == */opt/fzf/bin* ]]; then
#   export PATH="${PATH:+${PATH}:}/opt/fzf/bin"
# fi

# Auto-completion
# ---------------
# [[ $- == *i* ]] && source "/usr/share/doc/fzf/examples/completion.zsh" 2> /dev/null
[[ $- == *i* ]] && source "/usr/share/fzf/completion.zsh" 2> /dev/null

# Key bindings
# ------------
# [[ $- == *i* ]] && source "/usr/share/doc/fzf/examples/key-bindings.zsh" 2> /dev/null
[[ $- == *i* ]] && source "/usr/share/fzf/key-bindings.zsh" 2> /dev/null
