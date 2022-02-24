#!/usr/bin/env bash

NC="\033[m"
RED="\033[1;31m"
CYAN="\033[1;36m"
GREEN="\033[1;32m"

DOTFILES="$HOME/.dotfiles"
USER_ENVS="\$HOME/.config/zsh/exports.zsh"

dependencies=(
  bat
  delta
  exa
  fd
  fzf
  gcc
  kitty
  node
  nvim
  rg
  starship
  stow
  tmux
  xsel
  zoxide
  zsh
)

missing=()

info() {
  echo -e "\n${CYAN}info:${NC} $1"
}


erro() {
  echo -e "\n${RED}ERRO:${NC} $1"
}

installed() {
  if [ -x "$(command -v "$1")" ]; then
    echo -e "${GREEN} ✓${NC} $1"
    return 0
  else
    echo -e "${RED} ✗${NC} $1 <-- (não encontrado)"
    return 1
  fi
}

check_sys_deps() {
  if ! installed git || ! installed curl; then
    echo -e "\nPor favor, instale e tente de novo."
    exit 1
  fi
}

clone_dotfiles() {
  [ -d "$DOTFILES" ] && { echo "Diretório $DOTFILES já existe." && return; }
  git clone https://github.com/magalhaesm/dotfiles.git "$DOTFILES"
}

check_deps() {
  for dep in "${dependencies[@]}"; do
    ! installed "$dep" && missing+=("$dep")
  done
  [ "${#missing[@]}" -gt 0 ] && { erro "Dependências faltando."; exit 1; }
}

install_missing() {
  if [ "${#missing[@]}" != 0 ]; then
    read -p " Instalar dependências faltando? [y/N] " -r install
    [ "$install" != "y" ] && exit

    info "Instalando dependências..."
    for tool in "${missing[@]}"; do
      echo -e " ==> ${GREEN}${tool}${NC}"
      "$DOTFILES/scripts/install-$tool"
    done
  fi
}

config() {
  [ -d "$1" ] && stow -vt "$HOME" "$1"
}

stow_configs() {
  pushd "$DOTFILES" &>/dev/null || exit

  config git
  for tool in "${dependencies[@]}"; do
    config "$tool"
  done

  popd &>/dev/null || exit
}

set_zshenv() {
  local file="/etc/zsh/zshenv"
  if ! grep -q $USER_ENVS $file; then
    echo "Editando $file"

    echo -e "\n# Variáveis de ambiente do usuário" | sudo tee -a $file
    echo "[ -f $USER_ENVS ] && source $USER_ENVS" | sudo tee -a $file
    info "Reinicie a sessão para que as modificações tenham efeito."
  fi
}

set_shell() {
  local zsh
  zsh=$(command -v zsh)
  [ "$SHELL" != "$zsh" ] && sudo chsh -s "$zsh" "$USER" || echo "Já configurado."
}

main() {
  echo "---------------------------------------------------------"
  echo " ==> Instalando terminal, ferramentas e configurações"
  echo "---------------------------------------------------------"

  info "Verificando dependências de instalação..."
  check_sys_deps

  info "Obtendo repositório..."
  clone_dotfiles

  info "Verificando dependências do ambiente..."
  check_deps
  # install_missing

  info "Vinculando arquivos de configuração..."
  stow_configs

  info "Configurando variáveis de ambiente..."
  set_zshenv

  info "Instalando Oh-my-zsh..."
  "$DOTFILES/scripts/install-omz"

  info "Configurando zsh como shell padrão..."
  set_shell
}

main "$@"
