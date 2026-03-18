#!/usr/bin/env bash

NC="\033[m"
CYAN="\033[1;36m"
GREEN="\033[1;32m"

DOTFILES="$HOME/.dotfiles"

info() {
  echo -e "\n${CYAN}info:${NC} $1"
}

check_sys_deps() {
  if ! command -v git &>/dev/null || ! command -v stow &>/dev/null; then
    echo -e "\nInstall 'git' and 'stow' before running this script."
    exit 1
  fi
}

clone_dotfiles() {
  if [ -d "$DOTFILES" ]; then
    echo "Directory $DOTFILES already exists."
    return
  fi

  git clone https://github.com/magalhaesm/dotfiles.git "$DOTFILES"
}

config() {
  if [ -d "$1" ]; then
    stow -vt "$HOME" "$1"
  fi
}

stow_configs() {
  local packages=(
    bat
    fzf
    gdb
    git
    kitty
    kde
    nvim
    starship
    stylua
    tmux
    zsh
  )

  for tool in "${packages[@]}"; do
    (cd "$DOTFILES" && config "$tool")
  done
}

main() {
  echo "---------------------------------------------------------"
  echo " ==> Linking dotfiles"
  echo "---------------------------------------------------------"

  info "Checking bootstrap dependencies..."
  check_sys_deps

  info "Cloning dotfiles repository..."
  clone_dotfiles

  info "Linking configuration files..."
  stow_configs

  echo -e "\n${GREEN}✓${NC} Dotfiles linked successfully."
  echo
  echo "Next steps:"
  echo "  - Run '$DOTFILES/scripts/check.sh' to review recommended tools."
  echo "  - Install optional tools you actually use."
  echo "  - Install Oh My Zsh manually if desired."
  echo "  - Change your default shell manually if desired."
}

main
