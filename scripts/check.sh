#!/usr/bin/env bash

NC="\033[m"
CYAN="\033[1;36m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"

required=(
  git
  stow
  zsh
)

recommended=(
  bat
  delta
  eza
  fd
  fzf
  gcc
  kitty
  lazygit
  make
  nvim
  npm
  rg
  starship
  tmux
  unzip
  xsel
  zoxide
)

found=0
missing=0

print_header() {
  echo "---------------------------------------------------------"
  echo " ==> Dotfiles dependency check"
  echo "---------------------------------------------------------"
}

check_group() {
  local label=$1
  shift

  echo -e "\n${CYAN}${label}${NC}"

  for dep in "$@"; do
    if command -v "$dep" >/dev/null 2>&1; then
      echo -e "${GREEN} ✓${NC} $dep"
      found=$((found + 1))
    else
      echo -e "${YELLOW} !${NC} $dep"
      missing=$((missing + 1))
    fi
  done
}

main() {
  print_header
  check_group "Required" "${required[@]}"
  check_group "Recommended" "${recommended[@]}"

  echo -e "\n${CYAN}Summary${NC}"
  echo -e "${GREEN} Found:${NC} $found"
  echo -e "${YELLOW} Missing:${NC} $missing"

  if [ "$missing" -gt 0 ]; then
    echo -e "\nInstall the missing tools you care about. The shell config tolerates many optional tools."
  fi
}

main
