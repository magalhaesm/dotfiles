# Neovim config

Estrutura atual:

- `lua/plugins/ui.lua`: temas, dashboard, statusline e elementos visuais
- `lua/plugins/editor.lua`: edição de texto, which-key, buffers e utilitários
- `lua/plugins/navigation.lua`: exploração de arquivos e busca
- `lua/plugins/coding.lua`: LSP, completion, treesitter e formatação
- `lua/plugins/tools.lua`: Git, testes e depuração
- `lua/plugins/langs.lua`: integrações específicas por linguagem

Notas:

- `plugins.bak/` existe apenas como referência temporária da estrutura anterior.
- A intenção é manter a configuração agrupada por responsabilidade, não por plugin isolado.
