--------------------------------------------------------------------------------
--  ███╗   ███╗███╗   ███╗
--  ████╗ ████║████╗ ████║   Marcelo Magalhães
--  ██╔████╔██║██╔████╔██║   https://github.com/magalhaesm
--  ██║╚██╔╝██║██║╚██╔╝██║   marcelomagalhaes@protonmail.com
--  ██║ ╚═╝ ██║██║ ╚═╝ ██║
--  ╚═╝     ╚═╝╚═╝     ╚═╝
--------------------------------------------------------------------------------

------------------------------------------------------------------------
-- Leader bindings
------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = ","

------------------------------------------------------------------------
-- Plugin Configurations
------------------------------------------------------------------------
pcall(require, "impatient")

require "mm.bootstrap"

require "mm.globals"
require "mm.options"
require "mm.plugins"
require "mm.keymaps"
require "mm.autocommands"
require "mm.lsp"
