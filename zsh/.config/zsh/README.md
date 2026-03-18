# Zsh config

Estrutura da configuracao:

- `.zshenv`: ambiente global e `PATH`
- `.zshrc`: carregador principal
- `lib/functions.zsh`: funcoes auxiliares
- `conf.d/options.zsh`: opcoes do shell
- `conf.d/interactive.zsh`: historico e preferencias interativas
- `conf.d/fzf.zsh`: configuracao do `fzf`
- `conf.d/plugins.zsh`: plugins do `oh-my-zsh`
- `conf.d/tools.zsh`: integracoes com ferramentas externas
- `conf.d/completions.zsh`: `fpath` e `compinit`
- `aliases.zsh`: aliases pessoais
- `keybindings.zsh`: atalhos do teclado

Dependencias mais relevantes:

- `oh-my-zsh`
- plugins `asdf`, `zsh-autosuggestions`, `fast-syntax-highlighting`
- `fzf`
- `eza`
- `bat`
- `tmux`
- `zoxide`
- `starship`
- `asdf`
- `opam`

Notas:

- Arquivos locais e secretos sao carregados por ultimo a partir de `$HOME/Dropbox/dotfiles/secrets`.
- O cache de completion do zsh vai para `$XDG_CACHE_HOME/zsh/.zcompdump`.
- Se alguma ferramenta opcional nao estiver instalada, a configuracao tenta continuar sem falhar.
- Para voltar rapidamente ao comportamento antigo de aliases opcionais, exporte `DOTFILES_LEGACY_OPTIONALS=1`.
