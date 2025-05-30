local o = vim.opt

o.mouse = 'n' -- allow the mouse to be used in normal mode
o.clipboard = 'unnamedplus' -- allows neovim to access the system clipboard
o.fileencoding = 'utf-8' -- the encoding written to a file
o.hlsearch = true -- highlight all matches on previous search pattern
o.termguicolors = true -- set term gui colors (most terminals support this)

o.pumblend = 5 -- Popup blend
o.pumheight = 10 -- pop up menu height
o.showmode = false -- we don't need to see things like -- INSERT -- anymore
o.cmdheight = 1 -- more space in the neovim command line for displaying messages

o.smartcase = true -- smart case
o.smartindent = true -- make indenting smarter again
o.ignorecase = true -- ignore case in search patterns

o.splitbelow = true -- force all horizontal splits to go below current window
o.splitright = true -- force all vertical splits to go to the right of current window

o.undofile = true -- enable persistent undo
o.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
o.updatetime = 250 -- faster completion (4000ms default)

-- o.expandtab = true -- convert tabs to spaces
o.tabstop = 4 -- insert 4 spaces for a tab
o.softtabstop = 4
o.shiftwidth = 4 -- the number of spaces inserted for each indentation
o.expandtab = true

o.cursorline = true -- highlight the current line

o.number = true -- set numbered lines
o.relativenumber = true -- set relative numbered lines
o.signcolumn = 'yes' -- always show the sign column otherwise it would shift the text each time

o.wrap = true -- wrap lines longer than the width of the window
o.breakindent = true -- continue visually indented when wrapped
o.scrolloff = 10 -- lines to keep above and below the cursor
o.showcmd = false -- show command in the last line of the screen

o.list = true -- show invisible characters
o.listchars = { tab = '» ', nbsp = '␣', trail = '•', extends = '»', precedes = '«' }
o.showbreak = '⤷ '

o.shortmess:append({ W = true, I = true, c = true })

o.whichwrap:append('<,>,[,]')

o.formatoptions:append('t')
