local fmt = string.format
local log = vim.log.levels

-----------------------------------------------------------------------------//
-- Global namespace
-----------------------------------------------------------------------------//
_G.mm = {}

---Require a module using [pcall] and report any errors
---@param module string
---@param opts table
---@return boolean, any
function mm.safe_require(module, opts)
  opts = opts or { silent = false }
  local ok, result = pcall(require, module)
  if not ok and not opts.silent then
    vim.notify(result, log.ERROR, { title = fmt("Error requiring: %s", module) })
  end
  return ok, result
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

function _G.inspect(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
end

-- TODO: test
--- automatically clear commandline messages after a few seconds delay
--- source: http://unix.stackexchange.com/a/613645
---@return function
function mm.clear_commandline()
  --- Track the timer object and stop any previous timers before setting
  --- a new one so that each change waits for 10secs and that 10secs is
  --- deferred each time
  local timer
  return function()
    if timer then
      timer:stop()
    end
    timer = vim.defer_fn(function()
      if vim.fn.mode() == "n" then
        vim.cmd [[echon '']]
      end
    end, 10000)
  end
end

vim.cmd [[
  function! Empty_message(timer)
    if mode() ==# 'n'
      echon ''
    endif
  endfunction
]]
