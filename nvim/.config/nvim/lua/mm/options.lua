local options = {
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 1,                           -- more space in the neovim command line for displaying messages
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "n",                             -- allow the mouse to be used in normal mode
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                         -- always show tabs
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 500,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 1000,                       -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  cursorline = true,                       -- highlight the current line
  cursorlineopt = "number",                -- how cursorline is displayed (default: number,line)
  number = true,                           -- set numbered lines
  relativenumber = true,                   -- set relative numbered lines
  numberwidth = 4,                         -- set number column width (default 4)
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = false,                            -- wrap lines longer than the width of the window
  breakindent = true,                      -- continue visually indented when wrapped
  scrolloff = 8,                           -- lines to keep above and below the cursor
  sidescrolloff = 8,                       -- columns to keep to the left and to the right
  showcmd = false,                         -- show command in the last line of the screen
  list = true,                             -- show invisible characters
  showbreak = "⤷ ",
}

vim.opt.listchars = { tab = "»∙" }
vim.opt.listchars:append { nbsp = "␣" }
vim.opt.listchars:append { trail = "•" }
vim.opt.listchars:append { extends = "»" }
vim.opt.listchars:append { precedes = "«" }

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.whichwrap:append "<,>,[,],h,l"
vim.opt.iskeyword:append "-"
