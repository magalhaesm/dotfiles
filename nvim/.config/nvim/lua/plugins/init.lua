------------------------------------------------------------------------------
--  Packer Config:
------------------------------------------------------------------------------

local fn = vim.fn

local install_folder = fn.stdpath "data" .. "/site/pack/packer"

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

    -- Refactoring
    use {
      "ThePrimeagen/refactoring.nvim",
      event = "BufRead",
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" },
      },
      config = function()
        require "plugins.refactoring"
      end,
    }

    -- Which Key
    use {
      "folke/which-key.nvim",
      event = "VimEnter",
      config = function()
        require "plugins.which-key"
      end,
    }

    -- use { "plasticboy/vim-markdown", event = "BufRead", filetypes = "markdown" }

    -- Todo Comments
    use {
      "folke/todo-comments.nvim",
      event = "VimEnter",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require "plugins.todo-comments"
      end,
    }

    -- LSP
    use { "neovim/nvim-lspconfig" }
    use { "kabouzeid/nvim-lspinstall" }
    use { "jose-elias-alvarez/null-ls.nvim" }

    -- Autocomplete
    use {
      "hrsh7th/nvim-compe",
      event = "InsertEnter",
      config = function()
        require("plugins.compe").config()
      end,
    }

    -- TreeSitter
    use {
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require "plugins.treesitter"
      end,
    }
    use { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufRead" }
    use { "nvim-treesitter/playground", event = "BufRead" }

    -- Snippets
    use { "hrsh7th/vim-vsnip", event = "InsertCharPre" }
    use { "rafamadriz/friendly-snippets", event = "InsertCharPre" }

    -- NvimColorizer
    use {
      "norcalli/nvim-colorizer.lua",
      event = "BufRead",
      config = function()
        require("colorizer").setup()
      end,
    }

    -- Themes
    use { "~/.config/nvim/themes/dracula.nvim", requires = "rktjmp/lush.nvim" }

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
      event = "VimEnter",
      config = function()
        require "plugins.bufferline"
      end,
    }

    -- Lualine
    use {
      "hoob3rt/lualine.nvim",
      event = "VimEnter",
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
      event = "VimEnter",
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
      requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
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
        require("nvim_comment").setup()
      end,
    }

    -- Indent guide
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufWinEnter",
      config = function()
        require "plugins.blankline"
      end,
    }
  end,
  config = {
    compile_path = fn.stdpath "data" .. "/site/plugin/packer_compiled.vim",
    display = {
      open_fn = function()
        return require("packer.util").float { border = "single" }
      end,
    },
  },
}
