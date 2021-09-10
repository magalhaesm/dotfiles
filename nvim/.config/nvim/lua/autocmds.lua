-------------------------------------------------------------------------------
--  AutoCommands:
-------------------------------------------------------------------------------

local autocmds = {
  _general = {
    {
      "FileType",
      "help,man,qf",
      [[nnoremap <buffer><silent> q :close<CR>]],
    },
    {
      "FileType",
      "qf",
      "set nobuflisted",
    },
    {
      "TextYankPost",
      "*",
      "lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})",
    },
  },
  _lsp = {
    {
      "FileType",
      "lspinfo,null-ls-info",
      [[nnoremap <buffer><silent> q :close<CR>]],
    },
  },
  _filetypes = {
    { "BufNewFile,BufRead", "*.toml", "setf toml" },
    { "BufNewFile,BufRead", "*.s,*.asm", "setf asm" },
    { "BufNewFile,BufRead", "tmux*", "setf tmux" },
    { "BufNewFile,BufRead", "*rc", "setf conf" },
    { "BufNewFile,BufRead", "*rc", "setf conf" },
    {
      "FileType",
      "c,cpp",
      [[setlocal ts=4 sw=4 sts=4 commentstring=//%s]],
    },
    {
      "FileType",
      "toml",
      [[set commentstring=#%s]],
    },
  },
  packer = {
    { "BufWritePost", "*/plugins/init.lua", "source <afile> | PackerCompile" },
  },
}

---Create autocommand groups
function mm.define_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.cmd("augroup " .. group_name)
    vim.cmd "autocmd!"

    for _, def in pairs(definition) do
      local command = table.concat(vim.tbl_flatten { "autocmd", def }, " ")
      vim.cmd(command)
    end

    vim.cmd "augroup END"
  end
end

mm.define_augroups(autocmds)
