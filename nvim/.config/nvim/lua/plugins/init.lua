------------------------------------------------------------------------------
--  Packer Config:
------------------------------------------------------------------------------

local fn = vim.fn

local install_folder = mm.DATA_PATH .. "/site/pack/packer"

if fn.empty(fn.glob(install_folder)) > 0 then
  print "Rode o script de instalação... "
  if fn.getchar() ~= nil then
    vim.cmd "quit"
  end
end

local packer = require "packer"
local use = packer.use

return require("packer").startup {
  function()
    -- Plugin Manager
    use { "wbthomason/packer.nvim" }

    -- Which Key
    use {
      "folke/which-key.nvim",
      event = "BufRead",
      config = function()
        require "plugins.which-key"
      end,
    }

    -- LSP
    use { "kabouzeid/nvim-lspinstall", event = "BufRead" }
    use { "jose-elias-alvarez/null-ls.nvim", after = "nvim-lspinstall" }
    use {
      "neovim/nvim-lspconfig",
      after = "null-ls.nvim",
      config = function()
        require "lsp"
      end,
    }

    -- Autocompletion
    use {
      "hrsh7th/nvim-cmp",
      after = "LuaSnip",
      config = function()
        require "plugins.compe"
      end,
    }
    -- Snippet engine
    use { "L3MON4D3/LuaSnip", after = "nvim-lspconfig" }

    -- Completion sources
    use { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" }
    use { "hrsh7th/cmp-path", event = "InsertEnter" }
    use { "hrsh7th/cmp-nvim-lua", event = "InsertEnter" }
    use { "hrsh7th/cmp-buffer", event = "InsertEnter" }
    use { "saadparwaiz1/cmp_luasnip", event = "InsertEnter" }

    -- TreeSitter
    use {
      "nvim-treesitter/nvim-treesitter",
      event = "BufRead",
      config = function()
        require "plugins.treesitter"
      end,
    }
    use { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" }
    use { "nvim-treesitter/playground", after = "nvim-treesitter" }

    -- Refactoring
    use {
      "ThePrimeagen/refactoring.nvim",
      after = "nvim-treesitter",
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" },
      },
      config = function()
        require "plugins.refactoring"
      end,
    }

    -- NvimColorizer
    use {
      "norcalli/nvim-colorizer.lua",
      event = "BufRead",
      config = function()
        require("colorizer").setup()
      end,
    }

    -- Todo Comments
    use {
      "folke/todo-comments.nvim",
      event = "BufRead",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require "plugins.todo-comments"
      end,
    }

    -- Themes
    use {
      "~/.config/nvim/themes/dracula.nvim",
      requires = "rktjmp/lush.nvim",
      config = function()
        vim.cmd "colorscheme dracula"
      end,
      cond = function()
        if mm.colorscheme == "dracula" then
          return true
        end
      end,
    }

    -- GitSigns
    use {
      "lewis6991/gitsigns.nvim",
      event = "BufRead",
      config = function()
        require("plugins.gitsigns").config()
      end,
    }

    -- Bufferline
    use {
      "akinsho/nvim-bufferline.lua",
      after = "nvim-web-devicons",
      config = function()
        require "plugins.bufferline"
      end,
    }

    -- Lualine
    use {
      "hoob3rt/lualine.nvim",
      after = "nvim-web-devicons",
      config = function()
        require("plugins.lualine").config()
      end,
    }

    -- Autopairs
    use {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
        require("nvim-autopairs").setup()
      end,
    }

    -- Dashboard
    use {
      "glepnir/dashboard-nvim",
      event = "BufRead",
      config = require("plugins.dashboard").config(),
    }

    -- NvimTree
    use {
      "kyazdani42/nvim-tree.lua",
      event = "BufWinEnter",
      config = function()
        require("plugins.nvimtree").config()
      end,
    }

    -- Dev Icons
    use {
      "kyazdani42/nvim-web-devicons",
      config = function()
        require "plugins.icons"
      end,
    }

    -- Undo Tree
    use { "mbbill/undotree", event = "BufRead" }

    -- Telescope
    use {
      "nvim-telescope/telescope.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      event = "VimEnter",
      config = function()
        require "plugins.telescope"
      end,
    }

    -- Smooth scroll
    use {
      "karb94/neoscroll.nvim",
      event = "BufRead",
      config = function()
        require("neoscroll").setup()
      end,
    }

    -- Comments
    use {
      "terrortylor/nvim-comment",
      event = "BufRead",
      config = function()
        require("nvim_comment").setup { comment_empty = false }
      end,
    }

    -- Indent guide
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      config = function()
        require "plugins.blankline"
      end,
    }
  end,
  config = {
    compile_path = mm.DATA_PATH .. "/site/plugin/packer_compiled.vim",
    display = {
      open_fn = function()
        return require("packer.util").float { border = "single" }
      end,
    },
  },
}
