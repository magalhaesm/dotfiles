#!/usr/bin/env bash

set -Eeuo pipefail

NC="\033[m"
CYAN="\033[1;36m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"

DOTFILES="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

COMMON_PACKAGES=(
  bat
  fzf
  git
  kitty
  nvim
  starship
  stylua
  tmux
  zsh
)

LINUX_PACKAGES=(
  gdb
  kde
)

MACOS_PACKAGES=()

info() {
  printf "\n%binfo:%b %s\n" "$CYAN" "$NC" "$1"
}

detect_os() {
  case "$(uname -s)" in
    Darwin) OS="macos" ;;
    Linux) OS="linux" ;;
    *)
      printf "Unsupported operating system: %s\n" "$(uname -s)" >&2
      exit 1
      ;;
  esac
}

check_sys_deps() {
  if command -v git >/dev/null 2>&1 && command -v stow >/dev/null 2>&1; then
    return
  fi

  if [ "$OS" = "macos" ]; then
    printf "\nInstall the required dependencies with:\n  brew install git stow\n"
  else
    printf "\nInstall 'git' and 'stow' using your distribution's package manager.\n"
  fi

  exit 1
}

config() {
  local package=$1

  if [ ! -d "$DOTFILES/$package" ]; then
    printf "%bwarning:%b package '%s' not found; skipping.\n" "$YELLOW" "$NC" "$package"
    return
  fi

  stow --dir="$DOTFILES" --target="$HOME" --restow "$package"
}

stow_configs() {
  local packages=("${COMMON_PACKAGES[@]}")

  if [ "$OS" = "linux" ]; then
    packages+=("${LINUX_PACKAGES[@]}")
  elif [ "${#MACOS_PACKAGES[@]}" -gt 0 ]; then
    packages+=("${MACOS_PACKAGES[@]}")
  fi

  local package
  for package in "${packages[@]}"; do
    config "$package"
  done
}

main() {
  printf "%s\n" "---------------------------------------------------------"
  printf "%s\n" " ==> Linking dotfiles"
  printf "%s\n" "---------------------------------------------------------"

  detect_os

  info "Checking bootstrap dependencies..."
  check_sys_deps

  info "Linking configuration files..."
  stow_configs

  printf "\n%b✓%b Dotfiles linked successfully.\n\n" "$GREEN" "$NC"
  printf "%s\n" "Next steps:"
  printf "  - Run '%s/scripts/check.sh' to review recommended tools.\n" "$DOTFILES"
  printf "%s\n" "  - Install optional tools you actually use."
  printf "%s\n" "  - Install Oh My Zsh manually if desired."
  printf "%s\n" "  - Change your default shell manually if desired."
}

main
