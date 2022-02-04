-----------------------------------------------------------------------------//
-- Global namespace
-----------------------------------------------------------------------------//
_G.mm = {}

mm.lsp = {
  kind_icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
  },
}

function _G.inspect(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
end

---Function equivalent to basename in POSIX systems
---@param path string
---@return string
function mm.basename(path)
  local name = string.gsub(path, "(.*/)(.*)", "%2")
  return name
end

-- Credit: stoeffel/.dotfiles
vim.cmd [[
  function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
  endfunction
]]

-- xnoremap('@', ':<C-u>call ExecuteMacroOverVisualRange()<CR>', { silent = false })

---Limpa todos os registradores
function mm.WipeRegisters()
  local regs = 'abcdefghijklmnopqrstuvwxyz0123456789/-"'
  for reg in string.gmatch(regs, "[%w%p]") do
    vim.fn.setreg(reg, "")
  end
  print "Registradores limpos!"
end

vim.cmd "command -nargs=0 WipeRegisters lua mm.WipeRegisters()"
