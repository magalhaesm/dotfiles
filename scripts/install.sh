#!/usr/bin/env bash

RED="\033[1;31m"
CYAN="\033[1;36m"
GREEN="\033[1;32m"
NC="\033[m"

DOTFILES="$HOME/.dotfiles"

info() {
  echo -e "\n${CYAN}info:${NC} $1"
}

clone_repo() {
  [ -d "$DOTFILES" ] && { echo "Directory $DOTFILES already exists." && return; }
  git clone https://github.com/magalhaesm/dotfiles.git "$DOTFILES"
}

dependencies=(
  curl stow git delta zsh kitty gcc fzf nvim
  bat rg zoxide fd tmux node starship
)

missing=()

echo "---------------------------------------------------------"
echo " Installing terminal, tools and configurations "
echo "---------------------------------------------------------"

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
  # TODO: this could be better
  read -rp " Install missing dependencies? [y/N] " install
  [ "$install" != "y" ] && exit

  info "Installing dependencies..."
  for tool in "${missing[@]}"
  do
    "$DOTFILES/scripts/install-$tool"
  done
fi

info "Obtaining repository..."
clone_repo

info "Setting up..."
cd "$DOTFILES" || exit
for tool in "${dependencies[@]}"
do
  [ -d "$tool" ] && stow -vt "$HOME" "$tool"
done
cd - &>/dev/null || exit
