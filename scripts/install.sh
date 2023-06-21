#!/usr/bin/env bash

NC="\033[m"
RED="\033[1;31m"
CYAN="\033[1;36m"
GREEN="\033[1;32m"

DOTFILES="$HOME/.dotfiles"

dependencies=(
  bat
  delta  # required by git
  exa
  fd     # required by fzf
  fzf
  gcc    # required by nvim (treesitter)
  kitty
  npm    # required by nvim (Mason)
  unzip  # required by nvim (Mason)
  nvim
  rg     # required by nvim (Telescope)
  stow
  tmux
  xsel
  zoxide
  zsh
  lazygit
)

info() {
  echo -e "\n${CYAN}info:${NC} $1"
}

error() {
  echo -e "\n${RED}ERROR:${NC} $1"
}

installed() {
  if command -v "$1" &>/dev/null; then
    echo -e "${GREEN} ✓${NC} $1"
    return 0
  else
    echo -e "${RED} ✗${NC} $1 <-- (not found)"
    return 1
  fi
}

check_sys_deps() {
  if ! installed git || ! installed wget; then
    echo -e "\nPlease install the required dependencies and try again."
    exit 1
  fi
}

clone_dotfiles() {
  if [ -d "$DOTFILES" ]; then
    echo "Directory $DOTFILES already exists."
    return
  fi
  git clone https://github.com/magalhaesm/dotfiles.git \
    "$DOTFILES" || error "Failed to clone dotfiles repository."
}

check_deps() {
  for dep in "${dependencies[@]}"; do
    ! installed "$dep" && exit 1
  done
}

config() {
  if [ -d "$1" ]; then
    stow -vt "$HOME" "$1"
  fi
}

stow_configs() {
  (cd "$DOTFILES" && config git)
  for tool in "${dependencies[@]}"; do
    (cd "$DOTFILES" && config "$tool")
  done
}

set_shell() {
  local zsh

  zsh=$(command -v zsh)
  if [ "$SHELL" != "$zsh" ]; then
    if [ "$EUID" -eq 0 ]; then
      sudo chsh -s "$zsh" "$USER"
    else
      echo "You need administrative privileges to change the default shell."
    fi
  else
    echo "Shell already configured."
  fi
}

main() {
  echo "---------------------------------------------------------"
  echo " ==> Installing terminal, tools, and configurations"
  echo "---------------------------------------------------------"

  info "Checking installation dependencies..."
  check_sys_deps

  info "Cloning dotfiles repository..."
  clone_dotfiles

  info "Checking environment dependencies..."
  check_deps

  info "Linking configuration files..."
  stow_configs

  info "Installing Oh-my-zsh..."
  "$DOTFILES/scripts/install-omz"

  info "Setting zsh as the default shell..."
  set_shell

  info "Installation completed successfully."
}

main
