--------------------------------------------------------------------------------
--  ███╗   ███╗███╗   ███╗
--  ████╗ ████║████╗ ████║   Marcelo Magalhães
--  ██╔████╔██║██╔████╔██║   https://github.com/magalhaesm
--  ██║╚██╔╝██║██║╚██╔╝██║
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
require "mm.colorscheme"
require "mm.ui"
