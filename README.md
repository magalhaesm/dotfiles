# Marcelo's Dotfiles

> This repository provides my personal terminal configurations, including dotfiles and settings for various tools.

## Goals

- [x] Clones this repo to the local machine.
- [x] Links configuration files.
- [x] Provides a minimal bootstrap flow.
- [x] Provides a separate dependency check script.

## Notes

- Node is intentionally pinned manually in `zsh/.config/zsh/.zshenv`. Do not "simplify" or replace this without an explicit decision.

## Installation 🔧

1. Clone the repository

```sh
git clone https://github.com/magalhaesm/dotfiles.git ~/.dotfiles
```

2. Link the configurations

```sh
cd ~/.dotfiles
./scripts/install.sh
```

3. Review recommended tools

```sh
./scripts/check.sh
```

4. Install optional tools you actually use and complete any manual steps you want, such as:

- installing Oh My Zsh
- changing the default shell to `zsh`
- installing tools like `nvim`, `tmux`, `fzf`, `rg`, `fd`, `eza`, `bat`, `starship`, `zoxide`

5. Restart your terminal for the changes to take effect.

## License

[GPL-3.0](https://github.com/magalhaesm/dotfiles/blob/main/LICENSE)
