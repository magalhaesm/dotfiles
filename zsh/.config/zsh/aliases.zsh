alias v='nvim'
alias vim='nvim'
alias cn='${EDITOR} ~/.config/nvim/init.lua'
alias cz='${EDITOR} ${ZDOTDIR}/.zshrc'
alias ct='${EDITOR} ${TMUX_CONFIG}'
alias desk='cd "$XDG_DESKTOP_DIR"'

zsh_alias_if_cmd f fzf 'file=$(fzf --height 40%); if [ -n "$file" ]; then $EDITOR $file; fi'

if has_cmd bat; then
  alias cat='bat'
fi

# Por segurança, pergunta antes de sobrescrever algo
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias path='echo $PATH | tr -s ":" "\n"'
alias ip='ip -color=auto'

if has_cmd eza; then
  alias l='eza --color=always'
  alias ls='l'
  alias la='l -a'
  alias ll='l -lH --git --header'
  alias lla='ll -a'
  alias tree='eza -T -L2 --git -I ".git|.vim|node_modules|coverage|__pycache__"'
else
  alias ls='ls --color'
  alias l='l -CF'
  alias la='ls -Ah'
  alias ll='ls -lh'
  alias lla='ls -lAh'
fi

# alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'

# Easier to read disk (human-readable sizes)
alias df='df -h'
alias du='du -h'

# Open
zsh_alias_if_cmd o xdg-open 'nohup xdg-open >/dev/null'

# Git
alias g='git'
alias gc='git commit'
alias gs='git status -s'
alias gst='git status'
alias gl='git log --oneline --decorate --graph'
zsh_alias_if_cmd lg lazygit 'lazygit'

# Kitty terminal
zsh_alias_if_cmd kssh kitty 'kitty +kitten ssh'
