#!/usr/bin/env bash

NC="\033[m"
RED="\033[1;31m"
CYAN="\033[1;36m"
GREEN="\033[1;32m"

DOTFILES="$HOME/.dotfiles"
USER_ENVS="\$HOME/.config/zsh/exports.zsh"

info() {
  echo -e "\n${CYAN}info:${NC} $1"
}

installed() {
  if [ -x "$(command -v "$1")" ]
  then
    echo -e "${GREEN} ✓${NC} $1"
    return 0
  else
    echo -e "${RED} ✗${NC} $1 <-- (not installed)"
    return 1
  fi
}

clone_dotfiles() {
  [ -d "$DOTFILES" ] && { echo "Directory $DOTFILES already exists." && return; }
  git clone https://github.com/magalhaesm/dotfiles.git "$DOTFILES"
}

set_zshenv() {
  if ! grep -q $USER_ENVS /etc/zsh/zshenv
  then
    echo "Editing /etc/zsh/zshenv"

    echo -e "\n# Load user envs" | sudo tee -a /etc/zsh/zshenv
    echo -e "[ -f $USER_ENVS ] && source $USER_ENVS" | sudo tee -a /etc/zsh/zshenv
    info "Restart the session to take effect."
  fi
}

set_shell() {
  zsh=$(command -v zsh)
  if [ "$SHELL" != "$zsh" ]
  then
    chsh -s "$zsh" "$USER"
  else
    echo "Already configured."
  fi
}

config() {
  [ -d "$1" ] && stow -vt "$HOME" "$1"
}

echo "---------------------------------------------------------"
echo " ==> Installing terminal, tools and configurations "
echo "---------------------------------------------------------"

info "Checking main dependencies..."
if ! installed git || ! installed curl
then
  echo -e "\nPlease, install and try again."
  exit 1
fi

info "Obtaining repository..."
clone_dotfiles

dependencies=(
  stow kitty tmux delta
  nvim gcc node
  zsh rg bat zoxide fzf exa fd starship
)

missing=()

info "Checking dependencies..."
for dep in "${dependencies[@]}"
do
  ! installed "$dep" && missing+=("$dep")
done

if [ "${#missing[@]}" != 0 ]
then
  read -p " Install missing dependencies? [y/N] " -r install
  [ "$install" != "y" ] && exit

  info "Installing dependencies..."
  for tool in "${missing[@]}"
  do
    echo -e " ==> ${GREEN}$tool${NC}"
    "$DOTFILES/scripts/install-$tool"
  done
fi

info "Stowing configuration files..."
pushd "$DOTFILES" &>/dev/null || exit 1

config git
for tool in "${dependencies[@]}"
do
  config "$tool"
done

popd &>/dev/null || exit 1

info "Ensuring user environment variables..."
set_zshenv

info "Setting zsh as default shell..."
set_shell
