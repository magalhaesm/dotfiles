#!/usr/bin/env bash

NC="\033[m"
RED="\033[1;31m"
CYAN="\033[1;36m"
GREEN="\033[1;32m"

DOTFILES="$HOME/.dotfiles"
USER_ENVS="\$HOME/.config/zsh/exports.zsh"

dependencies=(
  stow kitty tmux delta
  nvim gcc node
  zsh rg bat zoxide fzf exa fd starship
)

missing=()

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

check_sys_deps() {
  if ! installed git || ! installed curl
  then
    echo -e "\nPlease, install and try again."
    exit 1
  fi
}

clone_dotfiles() {
  [ -d "$DOTFILES" ] && { echo "Directory $DOTFILES already exists." && return; }
  git clone https://github.com/magalhaesm/dotfiles.git "$DOTFILES"
}

check_deps() {
  for dep in "${dependencies[@]}"
  do
    ! installed "$dep" && missing+=("$dep")
  done
}

install_missing() {
  if [ "${#missing[@]}" != 0 ]
  then
    read -p " Install missing dependencies? [y/N] " -r install
    [ "$install" != "y" ] && exit

    info "Installing dependencies..."
    for tool in "${missing[@]}"
    do
      echo -e " ==> ${GREEN}${tool}${NC}"
      "$DOTFILES/scripts/install-$tool"
    done
  fi
}

config() {
  [ -d "$1" ] && stow -vt "$HOME" "$1"
}

stow_configs() {
  pushd "$DOTFILES" &>/dev/null || exit 1

  config git
  for tool in "${dependencies[@]}"
  do
    config "$tool"
  done

  popd &>/dev/null || exit 1
}

set_zshenv() {
  if ! grep -q $USER_ENVS /etc/zsh/zshenv
  then
    echo "Editing /etc/zsh/zshenv"

    echo -e "\n# Load user envs" | sudo tee -a /etc/zsh/zshenv
    echo -e "[ -f \"$USER_ENVS\" ] && source \"$USER_ENVS\"" | sudo tee -a /etc/zsh/zshenv
    info "Restart the session to take effect."
  fi
}

set_shell() {
  zsh=$(command -v zsh)
  [ "$SHELL" != "$zsh" ] && chsh -s "$zsh" "$USER" || echo "Already configured."
}

main() {
  echo "---------------------------------------------------------"
  echo " ==> Installing terminal, tools and configurations "
  echo "---------------------------------------------------------"

  info "Checking installation dependencies..."
  check_sys_deps

  info "Obtaining repository..."
  clone_dotfiles

  info "Checking dependencies..."
  check_deps
  install_missing

  info "Stowing configuration files..."
  stow_configs

  info "Ensuring user environment variables..."
  set_zshenv

  info "Setting zsh as default shell..."
  set_shell
}

main
