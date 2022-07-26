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
    -- Plugins here
    use "wbthomason/packer.nvim"
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "windwp/nvim-autopairs"
    use "numToStr/Comment.nvim"
    use "kyazdani42/nvim-web-devicons"
    use "kyazdani42/nvim-tree.lua"
    use "akinsho/bufferline.nvim"
    use "moll/vim-bbye"
    use "nvim-lualine/lualine.nvim"
    use "ahmedkhalf/project.nvim"
    use "lewis6991/impatient.nvim"
    use "lukas-reineke/indent-blankline.nvim"
    use "goolord/alpha-nvim"
    use "antoinemadec/FixCursorHold.nvim"
    use "folke/which-key.nvim"
    use "nvim-neorg/neorg"
    use "b0o/mapx.nvim"
    use "norcalli/nvim-colorizer.lua"
    use "karb94/neoscroll.nvim"

    -- Lua Docs
    use "nanotee/luv-vimdocs"
    use "milisims/nvim-luaref"

    -- Colorschemes
    use "lunarvim/darkplus.nvim"
    use "tanvirtin/monokai.nvim"

    -- cmp plugins
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "saadparwaiz1/cmp_luasnip"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"

    -- snippets
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"

    -- LSP
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"
    use "jose-elias-alvarez/null-ls.nvim"

    -- Telescope
    use "nvim-telescope/telescope.nvim"
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use "nvim-treesitter/playground"

    -- Git
    use "lewis6991/gitsigns.nvim"

    -- 42
    use "magalhaesm/42header.nvim"
    use "andweeb/presence.nvim"

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
