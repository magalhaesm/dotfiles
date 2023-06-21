# Marcelo's Dotfiles

> This repository provides my personal terminal configurations, including dotfiles and settings for various tools.

## Goals

- [x] Checks installation dependencies.
- [x] Provides a list with the dependencies.
- [x] Checks environment dependencies.
- [x] Clones this repo to the local machine.
- [x] Links configuration files.
- [x] Installs Oh-my-zsh and plugins.
- [x] Sets zsh as the default shell.

## Installation 🔧

1. Run the script
```sh
wget https://raw.githubusercontent.com/magalhaesm/dotfiles/main/scripts/install.sh
```

```sh
chmod +x install.sh
```

```sh
./install.sh
```

The script will check for the required dependencies and inform you if any are missing. No modifications will be made until all dependencies are satisfied. Execute the script as many times as necessary to check the dependencies.

2. Once all dependencies are met, the script will proceed to clone the dotfiles repository, link the configuration files, install Oh-my-zsh, and set zsh as the default shell.

> Note: If prompted, enter your password to change the default shell.

3. After the installation is complete, restart your terminal for the changes to take effect.
