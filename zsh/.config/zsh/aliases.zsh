alias v='vim' vim='nvim'
alias cn='${EDITOR} ~/.config/nvim/init.lua'
alias cz='${EDITOR} ${ZDOTDIR}/zshrc'
alias ct='${EDITOR} ${TMUX_CONFIG}'
alias f='file=$(fzf --height 40%); if [ -n "$file" ]; then $EDITOR $file; fi'

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

if [ -x "$(command -v exa)" ]
then
  # alias l='exa --color=always --group-directories-first'
  alias l='exa --color=always'
  alias ls='l'
  alias la='l -a'
  alias ll='l -lH --git'
  alias lla='ll -a'
  alias lst='l -T -L2 --git -I ".git|.vim|node_modules|coverage|__pycache__"'
  alias lat='lst -a'
else
  alias ls='ls --color'
  alias l='l -CF'
  alias la='ls -Ah'
  alias ll='ls -lh'
  alias lla='ls -lAh'
fi

alias listen='sudo lsof -i -P -n | grep LISTEN'
alias wget='wget --hsts-file=$XDG_CACHE_HOME/wget-hsts'

alias corona='curl https://corona-stats.online\?top\=10'

# Easier to read disk
alias df='df -h'                          # human-readable sizes
alias du='du -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

# Get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# Get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

# Gpg encryption
# Verify signature for isos
alias gpg-check='gpg2 --keyserver-options auto-key-retrieve --verify'
# Receive the key of a developer
alias gpg-retrieve='gpg2 --keyserver-options auto-key-retrieve --receive-keys'

# Nvim startup time
alias nvim-startup="nvim --startuptime /tmp/startup.log +q && nvim /tmp/startup.log"

# Kitty
alias icat="kitty +kitten icat"

# Open
alias o='xdg-open'

# Git
alias g='git'
alias gc='git commit'
alias gs='git status -s'
alias gst='git status'
alias gl='git log --oneline --decorate --graph'
