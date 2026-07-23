alias v='nvim'
alias vim='nvim'
alias cn='${EDITOR} ~/.config/nvim/init.lua'
alias cz='${EDITOR} ${ZDOTDIR}/.zshrc'
alias ct='${EDITOR} ${TMUX_CONFIG}'

desk() {
  cd "${XDG_DESKTOP_DIR:-$HOME/Desktop}"
}

zsh_alias_if_cmd f fzf 'file=$(fzf --height 40%); if [ -n "$file" ]; then $EDITOR $file; fi'

if has_cmd bat; then
  alias cat='bat'
fi

# Por segurança, pergunta antes de sobrescrever algo
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

# Colorize grep output (good for log files)
if printf '\n' | command grep --color=auto '' >/dev/null 2>&1; then
  alias grep='grep --color=auto'
  alias egrep='egrep --color=auto'
  alias fgrep='fgrep --color=auto'
fi

alias path='echo $PATH | tr -s ":" "\n"'
if has_cmd ip; then
  alias ip='ip -color=auto'
fi

if has_cmd eza; then
  alias l='eza --color=always'
  alias ls='l'
  alias la='l -a'
  alias ll='l -lH --git --header'
  alias lla='ll -a'
  alias tree='eza -T -L2 --git -I ".git|.vim|node_modules|coverage|__pycache__"'
else
  if [ "$(uname -s)" = "Darwin" ]; then
    alias ls='ls -G'
  else
    alias ls='ls --color=auto'
  fi
  alias l='ls -CF'
  alias la='ls -Ah'
  alias ll='ls -lh'
  alias lla='ls -lAh'
fi

# alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'

# Easier to read disk (human-readable sizes)
alias df='df -h'
alias du='du -h'

# Open
if [ "$(uname -s)" = "Darwin" ]; then
  zsh_alias_if_cmd o open 'open'
else
  zsh_alias_if_cmd o xdg-open 'nohup xdg-open >/dev/null'
fi

# Git
alias g='git'
alias gc='git commit'
alias gs='git status -s'
alias gst='git status'
alias gl='git log --oneline --decorate --graph'
zsh_alias_if_cmd lg lazygit 'lazygit'

# Kitty terminal
zsh_alias_if_cmd kssh kitty 'kitty +kitten ssh'
