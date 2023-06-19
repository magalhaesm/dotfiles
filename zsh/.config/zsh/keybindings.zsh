# === Keybindings ===

# Use emacs keybindings
bindkey -e

# Enter vim mode
bindkey "^v" vi-cmd-mode

# Browse history
bindkey "^p" up-line-or-history
bindkey "^n" down-line-or-history

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
