--  ▄▄▄ ▄▄    ▄ ▄▄▄ ▄▄▄▄▄▄▄      ▄▄▄     ▄▄   ▄▄ ▄▄▄▄▄▄
-- █   █  █  █ █   █       █    █   █   █  █ █  █      █
-- █   █   █▄█ █   █▄     ▄█    █   █   █  █ █  █  ▄   █
-- █   █       █   █ █   █      █   █   █  █▄█  █ █▄█  █
-- █   █  ▄    █   █ █   █  ▄▄▄ █   █▄▄▄█       █      █
-- █   █ █ █   █   █ █   █ █   ██       █       █  ▄   █
-- █▄▄▄█▄█  █▄▄█▄▄▄█ █▄▄▄█ █▄▄▄██▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█▄█ █▄▄█
--
-- Marcelo Magalhães <https://github.com/magalhaesm/dotfiles>

-------------------------------------------------------------------------------
--  GERENCIADOR DE PLUGINS: Packer
-------------------------------------------------------------------------------

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = ","

require "globals"
require "utils"
require "settings"
require "mappings"
require "autocmds"
require "plugins"
require "lsp"

-- Colorscheme
vim.cmd "colorscheme dracula"
