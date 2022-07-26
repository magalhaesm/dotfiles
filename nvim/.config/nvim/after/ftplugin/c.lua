vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.expandtab = false

nnoremap("<leader>;", "A;<ESC>")

vim.cmd [[
	augroup update_42header
	  autocmd!
	  autocmd BufWritePre *.c Ftupdate
	  autocmd BufWritePre *.h Ftupdate
	augroup END
]]
