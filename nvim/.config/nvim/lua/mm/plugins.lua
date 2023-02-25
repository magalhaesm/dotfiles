-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

local PACKER_COMPILED_PATH = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua"

-- Use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  log = { level = "info" },
}

return packer.startup {
  function(use)
    use "wbthomason/packer.nvim"
    use "windwp/nvim-autopairs"
    use "kylechui/nvim-surround"
    use "numToStr/Comment.nvim"
    use "kyazdani42/nvim-web-devicons"
    use "kyazdani42/nvim-tree.lua"
    use "akinsho/bufferline.nvim"
    use "moll/vim-bbye" --[[ sai ]]
    use "nvim-lualine/lualine.nvim"
    use "ahmedkhalf/project.nvim" --[[ sai ]]
    use "lewis6991/impatient.nvim" --[[ sai ]]
    use "lukas-reineke/indent-blankline.nvim"
    use "goolord/alpha-nvim"
    use "antoinemadec/FixCursorHold.nvim" --[[ sai ]]
    use "folke/which-key.nvim"
    use "nvim-neorg/neorg" --[[ sai ]]
    use "b0o/mapx.nvim" --[[ sai ]]
    use "norcalli/nvim-colorizer.lua"
    use "karb94/neoscroll.nvim"
    use "stevearc/dressing.nvim"

    -- Colorschemes
    use "lunarvim/darkplus.nvim"
    use "tanvirtin/monokai.nvim"
    use "gruvbox-community/gruvbox"

    -- Completion
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lsp"
    use {
      "L3MON4D3/LuaSnip",
      tag = "v<CurrentMajor>.*",
      run = "make install_jsregexp",
    }
    use "saadparwaiz1/cmp_luasnip"
    use "onsails/lspkind.nvim"
    use "rafamadriz/friendly-snippets"

    -- LSP
    use {
      "neovim/nvim-lspconfig",
      requires = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
      },
    }
    use "jose-elias-alvarez/null-ls.nvim"

    -- Telescope
    use "nvim-lua/plenary.nvim"
    use "nvim-telescope/telescope.nvim"
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      requires = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/playground"
      },
      run = ":TSUpdate"
    }

    -- Git
    use "lewis6991/gitsigns.nvim"

    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
    }
    -- 42
    use "magalhaesm/42header.nvim"
    use "andweeb/presence.nvim"

    -- Rust
    use "simrat39/rust-tools.nvim"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
  end,
  config = {
    compile_path = PACKER_COMPILED_PATH,
  },
}
