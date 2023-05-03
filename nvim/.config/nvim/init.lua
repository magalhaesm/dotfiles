vim.g.mapleader = " "
vim.g.maplocalleader = ","

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Auto-install lazy.nvim if not present (package manager)
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("config").setup()
require("lazy").setup("plugins", {
  ui = {
    border = "rounded",
    icons = {
      list = { "" },
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        -- "zipPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
      },
    },
  },
})
vim.cmd.colorscheme "catppuccin"
