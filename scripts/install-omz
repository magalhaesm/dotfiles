#!/usr/bin/env bash

export ZSH="$HOME/.config/oh-my-zsh"
[ -d "$ZSH" ] && { echo "Directory $ZSH already exists." ; exit ; }

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  "${ZSH}/themes/powerlevel10k"

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions \
  "${ZSH}/plugins/zsh-autosuggestions"

# fast-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  "${ZSH}/plugins/fast-syntax-highlighting"
