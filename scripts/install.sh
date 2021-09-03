#!/usr/bin/env bash

RED="\033[1;31m"
CYAN="\033[1;36m"
GREEN="\033[1;32m"
NC="\033[m"

DOTFILES="$HOME/.dotfiles"

clone_dotfiles() {
  [ -d "$DOTFILES" ] && { echo "Directory $DOTFILES already exists." && return; }
  git clone https://github.com/magalhaesm/dotfiles.git "$DOTFILES"
}

set_shell() {
  zsh="$(command -v zsh)"
  [ "$SHELL" != "$zsh" ] && chsh -s "$zsh" "$USER"
}

info() {
  echo -e "\n${CYAN}info:${NC} $1"
}

if_install() {
  [ ! -x "$(command -v "$1")" ] && sudo apt install "$1" || echo -e "${GREEN} ✓${NC} $1"
}

dependencies=(
  stow kitty zsh nvim gcc fzf
  bat delta rg zoxide fd tmux node starship
)

missing=()

echo "---------------------------------------------------------"
echo " ==> Installing terminal, tools and configurations "
echo "---------------------------------------------------------"

info "Getting main dependencies..."
if_install curl
if_install git

info "Obtaining repository..."
clone_dotfiles

info "Checking dependencies..."
for dep in "${dependencies[@]}"
do
  if [ -x "$(command -v "$dep")" ]
  then
    echo -e "${GREEN} ✓${NC} $dep"
  else
    echo -e "${RED} ✗${NC} $dep <-- (not installed)"
    missing+=("$dep")
  fi
done

if [ "${#missing[@]}" != 0 ]
then
  read -rp " Install missing dependencies? [y/N] " install
  [ "$install" != "y" ] && exit

  info "Installing dependencies..."
  for tool in "${missing[@]}"
  do
    "$DOTFILES/scripts/install-$tool"
  done
fi

info "Configuring..."
cd "$DOTFILES" || exit
for tool in "${dependencies[@]}"
do
  [ -d "$tool" ] && stow -vt "$HOME" "$tool"
done
cd - &>/dev/null || exit

info "Setting zsh as default shell..."
set_shell

info "Restart the session to take effect."
