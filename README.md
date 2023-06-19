<h1 align="center"> Dotfiles </h1>
<p align="center">
  <b><i>Welcome to my repository!</i></b><br>
</p>
<p align="center">
	<img alt="GitHub code size in bytes" src="https://img.shields.io/github/languages/code-size/magalhaesm/dotfiles?color=4caf50" />
	<img alt="Main language" src="https://img.shields.io/github/languages/top/MAGALHAESM/dotfiles?color=4caf50"/>
	<img alt="License" src="https://img.shields.io/github/license/magalhaesm/dotfiles?color=4caf50"/>
</p>

> This repository provides my personal terminal configurations, including dotfiles and settings for various tools.

## Dependencies 🛠️

The provided script automates the installation process, ensuring that all required dependencies are present before applying the configurations.

- `bat`: A syntax highlighting and paging tool for the terminal.
- `delta`: A code diff viewer (required by Git for enhanced diff viewing).
- `exa`: A modern replacement for the 'ls' command, providing improved file listing.
- `fd`: A fast and user-friendly alternative to 'find' (required by fzf for efficient file searching).
- `fzf`: A command-line fuzzy finder for quickly locating files, commands, and more.
- `gcc`: The GNU Compiler Collection (required by Neovim for enhanced code parsing and analysis).
- `kitty`: A cross-platform, GPU-accelerated terminal emulator.
- `npm`: Node.js package manager (required by Neovim for package management and plugin installation).
- `unzip`: A utility for extracting compressed files (required by Neovim for plugin installation).
- `nvim`: Neovim, an extensible text editor that enhances the Vim experience.
- `rg`: ripgrep, a fast line-oriented search tool (required by Neovim for fast text searching).
- `stow`: A symlink farm manager used for easily managing dotfile configurations.
- `tmux`: A terminal multiplexer that allows for multiple sessions and window management.
- `xsel`: A command-line tool for manipulating the X selection (clipboard).
- `zoxide`: A fast directory changer that uses intelligent matching algorithms.
- `zsh`: A powerful shell with advanced scripting capabilities.
- `lazygit`: A terminal-based UI for managing Git repositories with ease.

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

Feel free to customize and adapt these configurations to your liking. ✨💻

If you encounter any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.

## License 📝
This repo is licensed under the [GPL License](LICENSE).

<p align="center">⚡ Crafted by Marcelo Magalhães (magalhaesm) ⚡</p>
