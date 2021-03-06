vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo,null-ls-info nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 400})
    autocmd FileType qf set nobuflisted
    autocmd BufWinEnter * :set formatoptions-=o
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

  augroup _nvimtree
    autocmd!
    autocmd BufWinEnter NvimTree :set cursorlineopt=line
    autocmd BufWinLeave NvimTree :set cursorlineopt=number
  augroup end
]]
