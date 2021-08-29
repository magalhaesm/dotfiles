#!/usr/bin/env bash

RED="\033[1;31m"
CYAN="\033[1;36m"
GREEN="\033[1;32m"
NC="\033[m"

DOTFILES="$HOME/.dotfiles"

clone_ohmyzsh() {
  local ohmyzsh="$HOME/.config/oh-my-zsh"
  [ -d "$ohmyzsh" ] && return
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  mv ~/.oh-my-zsh "$ohmyzsh"
}

clone_zinit() {
  local zinit="$HOME/.config/zinit/bin"
  [ -d "$zinit" ] && return
  git clone https://github.com/zdharma/zinit.git "$zinit"
}

clone_dotfiles() {
  [ -d "$DOTFILES" ] && { echo "Directory $DOTFILES already exists." && return; }
  git clone https://github.com/magalhaesm/dotfiles.git "$DOTFILES"
}

set_shell() {
  zsh_path="$(command -v zsh)"
  [ "$SHELL" != "$zsh_path" ] && chsh -s "$zsh_path" "$USER"
}

info() {
  echo -e "\n${CYAN}info:${NC} $1"
}

dependencies=(
  curl stow git delta zsh kitty gcc fzf nvim
  bat rg zoxide fd tmux node starship
)

missing=()

echo "---------------------------------------------------------"
echo " Installing terminal, tools and configurations "
echo "---------------------------------------------------------"

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
  # TODO: this could be better
  read -rp " Install missing dependencies? [y/N] " install
  [ "$install" != "y" ] && exit

  info "Installing dependencies..."
  for tool in "${missing[@]}"
  do
    "$DOTFILES/scripts/install-$tool"
  done
fi

info "Preparing shell..."
clone_ohmyzsh
clone_zinit
set_shell

info "Setting up..."
cd "$DOTFILES" || exit
for tool in "${dependencies[@]}"
do
  [ -d "$tool" ] && stow -vt "$HOME" "$tool"
done
cd - &>/dev/null || exit

info "Restart the session to take effect."
