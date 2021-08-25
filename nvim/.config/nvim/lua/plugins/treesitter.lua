-------------------------------------------------------------------------------
--  TreeSitter:
-------------------------------------------------------------------------------

-- local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

-- parser_configs.markdown = {
--   install_info = {
--         url = "https://github.com/ikatyang/tree-sitter-markdown",
--         files = {"src/parser.c", "src/scanner.cc"}
--     },
--     filetype = "markdown",
-- }

-- parser_configs.norg = {
--   install_info = {
--     url = "https://github.com/vhyrro/tree-sitter-norg",
--     -- url = "/home/vhyrro/dev/tree-sitter-norg",;
--     files = { "src/parser.c" },
--     branch = "main",
--   },
-- }

require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "lua",
    "javascript",
    "typescript",
    "python",
    "cpp",
    "c",
    "bash",
    "html",
    "css",
    "query",
    "rust",
    "dart",
    "toml",
    "yaml",
  },

  highlight = {
    enable = true,
    -- Setting this to true or a list of languages will run `:h syntax` and tree-sitter at the same time.
    additional_vim_regex_highlighting = true,
  },

  incremental_selection = {
    enable = true,
    -- TODO: encontrar atalhos melhores para esse utilíssimo recurso!
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },

    lsp_interop = {
      enable = true,
      border = "single",
      peek_definition_code = {
        ["df"] = "@function.outer",
        ["dF"] = "@class.outer",
      },
    },
  },

  -- playground = {
  --   enable = true,
  --   disable = {},
  --   updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
  --   persist_queries = false -- Whether the query persists across vim sessions
  -- },
}

local nnoremap = mm.nnoremap
nnoremap("<F2>", "<cmd>TSHighlightCapturesUnderCursor<CR>")
nnoremap("<F3>", "<cmd>TSPlaygroundToggle<CR>")
