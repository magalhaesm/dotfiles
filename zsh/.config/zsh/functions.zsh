define_session() {
  WORKSPACE=$(basename "$PWD")
  [[ ${WORKSPACE:0:1} == "." ]] && echo "${WORKSPACE:1}" || echo "${WORKSPACE}"
}

ide() {
  SESSION=$(define_session)
  if ! tmux has-session -t "$SESSION" 2> /dev/null
  then
    tmux -f "$TMUX_CONFIG" new-session -s "$SESSION" -n editor -d
    tmux new-window -n terminal -t "$SESSION"
    tmux select-window -t "$SESSION":1
  fi
  tmux attach -t "$SESSION"
}

zsh_add_file() {
  [ -f "$1" ] && source "$1"
}

zsh_add_plugin() {
  PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
  if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
    # For plugins
    zsh_add_file "$ZDOTDIR/plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
    zsh_add_file "$ZDOTDIR/plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
  else
    git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
  fi
}

zsh_add_completion() {
  PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
  if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
    # For completions
    completion_file_path=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
    fpath+="$(dirname "${completion_file_path}")"
    zsh_add_file "$ZDOTDIR/plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
  else
    git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fpath+=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
    [ -f $ZDOTDIR/.zccompdump ] && $ZDOTDIR/.zccompdump
  fi
  completion_file="$(basename "${completion_file_path}")"
  if [ "$2" = true ] && compinit "${completion_file:1}"
}
