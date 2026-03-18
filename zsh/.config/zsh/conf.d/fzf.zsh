if has_cmd fd; then
  export FZF_DEFAULT_COMMAND="fd --type f --exclude '*.o'"
  export FZF_ALT_C_COMMAND="fd --type d"
else
  export FZF_DEFAULT_COMMAND="find . -type f ! -name '*.o'"
  export FZF_ALT_C_COMMAND="find . -type d"
fi

export FZF_DEFAULT_OPTS="
  --color=dark
  --color=fg:-1,bg:-1,hl:#ae81ff,fg+:#f8f8f0,bg+:-1,hl+:#ae81ff
  --color=info:#a6e22e,prompt:#66d9ef,pointer:#e95678
  --color=marker:#fd971f,spinner:#66d9ef,header:#66d9ef
  --height 100% --layout=reverse --no-border --cycle --info=inline
  --bind=ctrl-d:preview-page-down
  --bind=ctrl-u:preview-page-up
"

if has_cmd bat; then
  export FZF_BAT_PREVIEW="'bat --style=numbers --color=always --line-range :500 {}'"
else
  export FZF_BAT_PREVIEW="'sed -n 1,200p {}'"
fi

export FZF_COMPLETION_OPTS="--border"

if has_cmd eza; then
  export FZF_ALT_C_OPTS="--border --preview 'eza -T -L2 {} | head -200'"
else
  export FZF_ALT_C_OPTS="--border --preview 'find {} -maxdepth 2 | head -200'"
fi

export FZF_CTRL_R_OPTS="--height 40%"

export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_CTRL_T_OPTS="--border --preview ${FZF_BAT_PREVIEW}"

if has_cmd fzf; then
  zsh_add_file "$XDG_CONFIG_HOME/fzf/fzf.zsh"
fi
