# DEPOIS
nvim/
└── lua/
    └── plugins/
        ├── ui.lua           (temas, barras, visual)
        ├── editor.lua       (edição de texto, snippets, comentários)
        ├── navigation.lua   (navegação de arquivos, telescope, harpoon)
        ├── coding.lua       (LSP, completions, treesitter, formatação)
        ├── tools.lua        (integração com git, testes, depuração)
        └── langs.lua        (configurações específicas de linguagens)

# ANTES Segurida
nvim/
└── lua/
    └── plugins/
        ├── appearance.lua     (temas, UI, statusline)
        ├── navigation.lua     (telescope, neo-tree, harpoon)
        ├── lsp.lua            (LSP, autocompletion)
        ├── treesitter.lua     (treesitter e relacionados)
        ├── editor.lua         (indentação, comentários, edição)
        ├── git.lua            (integrações Git)
        ├── tools.lua          (ferramentas externas, terminal)
        └── utils.lua          (utilitários diversos)
