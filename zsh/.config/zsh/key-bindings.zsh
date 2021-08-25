# -- KEYBINDING ----------------------------------------------------------------

bindkey -v

# ci", ci', ci`, di", etc
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

# ci{, ci(, ci<, di{, etc
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^o' accept-and-infer-next-history

bindkey "^p" up-line-or-history
bindkey "^n" down-line-or-history

bindkey -M vicmd v edit-command-line
bindkey "^?" backward-delete-char

bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion

zle -N fm-invoke _run_fm
bindkey "^g" fm-invoke

zle -N ffd-d-invoke _run_ffd_d
bindkey "\ed" ffd-d-invoke

