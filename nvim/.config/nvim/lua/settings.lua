---------------------------------------------------------
-- SETTINGS:
---------------------------------------------------------
local g = vim.g
local opt = vim.opt
local cmd = vim.cmd

cmd "syntax on"
cmd "filetype plugin indent on"

mm.colorscheme = ""

opt.showmode = false
opt.hidden = true
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true

opt.updatetime = 250
opt.clipboard = "unnamedplus"
opt.timeoutlen = 500

opt.number = true
opt.relativenumber = true
opt.cursorline = false
opt.signcolumn = "yes"

opt.scrolloff = 8
opt.pumheight = 15

opt.conceallevel = 3

opt.completeopt = { "menuone", "noselect" }
opt.shortmess:append "c"

opt.whichwrap:append "<>"

opt.cmdheight = 1
opt.showcmd = false
opt.wildmenu = true
opt.wildignore = { ".git", ".hg", ".svn", "*.pyc", "*.o", "*.out", "*.jpg" }
opt.wildignore:append { "*.jpeg", "*.png", "*.gif", "*.zip", "**/tmp/**" }
opt.wildignore:append { "*.DS_Store", "**/node_modules/**", "**__pycache__/" }

opt.list = true -- exibir caracteres invisíveis
opt.showbreak = "↳ "
opt.listchars = { tab = "»∙" } -- Right-point double angle (U+00BB) + Bullet operator (U+2219)
opt.listchars:append { nbsp = "⦸" }
opt.listchars:append { trail = "•" }
opt.listchars:append { extends = "»" }
opt.listchars:append { precedes = "«" }

opt.backspace = { "indent", "eol", "start" }

opt.fillchars = "diff:∙" -- Bullet operator (U+2219)
opt.fillchars = opt.fillchars + "eob: " -- No-break space (U+00A0) to supress ~ at EndOfBuffer
opt.fillchars = opt.fillchars + "fold:·" -- Middle dot (U+00B7)
opt.fillchars = opt.fillchars + "vert:┃" -- Box drawing heavy vertical (U+2503)

-- Pesquisa
opt.ignorecase = true
opt.hlsearch = true
opt.incsearch = true
opt.smartcase = true

-- Dobra
opt.foldmethod = "indent"
opt.foldlevelstart = 99

-- Backup
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.swapfile = false

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.wrap = false
-- linebreak = true,
-- textwidth = 80,
opt.emoji = false -- don't assume all emoji are double width

-- Desabilita alguns plugins do vim
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end

-- Python Provider
g.python3_host_prog = "/usr/bin/python3"
