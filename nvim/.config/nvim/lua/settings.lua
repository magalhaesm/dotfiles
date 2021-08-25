---------------------------------------------------------
-- SETTINGS:
---------------------------------------------------------

vim.cmd "syntax on"
vim.cmd "filetype plugin indent on"

-- vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.hidden = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true

vim.opt.updatetime = 250
vim.opt.clipboard = "unnamedplus"
vim.opt.timeoutlen = 500

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = false
vim.opt.signcolumn = "yes"

vim.opt.scrolloff = 8
vim.opt.pumheight = 15

vim.opt.conceallevel = 3

vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.shortmess:append "c"

vim.opt.cmdheight = 1
vim.opt.showcmd = false
vim.opt.wildmenu = true
vim.opt.wildignore = { ".git", ".hg", ".svn", "*.pyc", "*.o", "*.out", "*.jpg" }
vim.opt.wildignore:append { "*.jpeg", "*.png", "*.gif", "*.zip", "**/tmp/**" }
vim.opt.wildignore:append { "*.DS_Store", "**/node_modules/**", "**__pycache__/" }

vim.opt.list = true -- exibir caracteres invisíveis
vim.opt.showbreak = "↳ "
vim.opt.listchars = { tab = "»∙" } -- Right-point double angle (U+00BB) + Bullet operator (U+2219)
vim.opt.listchars:append { nbsp = "⦸" }
vim.opt.listchars:append { trail = "•" }
vim.opt.listchars:append { extends = "»" }
vim.opt.listchars:append { precedes = "«" }

vim.opt.backspace = { "indent", "eol", "start" }

vim.opt.fillchars = "diff:∙" -- Bullet operator (U+2219)
vim.opt.fillchars = vim.opt.fillchars + "eob: " -- No-break space (U+00A0) to supress ~ at EndOfBuffer
vim.opt.fillchars = vim.opt.fillchars + "fold:·" -- Middle dot (U+00B7)
vim.opt.fillchars = vim.opt.fillchars + "vert:┃" -- Box drawing heavy vertical (U+2503)

-- Pesquisa
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartcase = true

-- Dobra
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99

-- Backup
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.swapfile = false

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false
-- linebreak = true,
-- textwidth = 80,
vim.opt.emoji = false -- don't assume all emoji are double width

-- Desabilita plugins da distribuição
-- vim.g.loaded_gzip              = 1
-- vim.g.loaded_tar               = 1
-- vim.g.loaded_tarPlugin         = 1
-- vim.g.loaded_zip               = 1
-- vim.g.loaded_zipPlugin         = 1
-- vim.g.loaded_getscript         = 1
-- vim.g.loaded_getscriptPlugin   = 1
-- vim.g.loaded_vimball           = 1
-- vim.g.loaded_vimballPlugin     = 1
-- vim.g.loaded_matchit           = 1
-- vim.g.loaded_matchparen        = 1
-- vim.g.loaded_2html_plugin      = 1
-- vim.g.loaded_logiPat           = 1
-- vim.g.loaded_rrhelper          = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- Python Provider
vim.g.python3_host_prog = "/usr/bin/python3"
