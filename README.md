# Marcelo's Dotfiles

> This repository provides my personal terminal configurations, including dotfiles and settings for various tools.

## Goals

- [x] Check installation dependencies
- [x] Clone dotfiles repository
- [x] Check environment dependencies
- [x] Link configuration files
- [x] Installing Oh-my-zsh
- [x] Setting zsh as the default shell

## Installation 🔧

1. Ensure that you have the necessary dependencies installed on your system.
```sh
curl -s https://raw.githubusercontent.com/magalhaesm/dotfiles/main/scripts/install.sh > install.sh
chmod +x install.sh
./install.sh
```
The script will check for the required dependencies and inform you if any are missing. No modifications will be made until all dependencies are satisfied. Execute the script as many times as necessary to check the dependencies.

2. Once all dependencies are met, the script will proceed to clone the dotfiles repository, link the configuration files, install Oh-my-zsh, and set zsh as the default shell.

> Note: If prompted, enter your password to change the default shell.

3. After the installation is complete, restart your terminal for the changes to take effect.
