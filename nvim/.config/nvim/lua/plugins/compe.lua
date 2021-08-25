-------------------------------------------------------------------------------
--  Compe:
-------------------------------------------------------------------------------

vim.o.completeopt = "menuone,noselect"
vim.g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }

local fn = vim.fn
local t = mm.replace_termcodes

-- local check_back_space = function()
--   local col = vim.fn.col '.' - 1
--   return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
-- end

--- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
-- _G.__tab_complete = function()
--   if fn.pumvisible() == 1 then
--     return t '<C-n>'
--   elseif fn['vsnip#available'](1) == 1 then
--     return t '<Plug>(vsnip-expand-or-jump)'
--   elseif check_back_space() then
--     return t '<Tab>'
--   else
--     return fn['compe#complete']()
--   end
-- end
-- _G.__s_tab_complete = function()
--   if fn.pumvisible() == 1 then
--     return t '<C-p>'
--   elseif fn['vsnip#jumpable'](-1) == 1 then
--     return t '<Plug>(vsnip-jump-prev)'
--   else
--     return t '<S-Tab>'
--   end
-- end

local M = {}

M.config = function()
  require("compe").setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    -- documentation = true,
    documentation = {
      border = "rounded",
      winhighlight = table.concat({
        "NormalFloat:CompeDocumentation",
        "Normal:CompeDocumentation",
        "FloatBorder:CompeDocumentationBorder",
      }, ","),
    },

    source = {
      path = { kind = "   (Path)" },
      buffer = { kind = "   (Buffer)" },
      calc = { kind = "   (Calc)" },
      vsnip = { kind = " ✀  (Snippet)" },
      nvim_lsp = { kind = "   (LSP)" },
      nvim_lua = true,
      spell = { kind = "   (Spell)" },
      tags = false,
      treesitter = false,
      emoji = { kind = " ﲃ  (Emoji)", filetypes = { "markdown", "text" } },
      neorg = true,
    },
  }

  -------------------------------------------------------------------------------
  --  Complete Functions:
  -------------------------------------------------------------------------------

  ---[[
  _G.tab_complete = function()
    if fn.pumvisible() == 1 then
      return t "<C-n>"
      -- elseif check_back_space() then
    else
      return t "<Tab>"
    end
  end

  _G.s_tab_complete = function()
    if fn.pumvisible() == 1 then
      return t "<C-p>"
    else
      return t "<S-Tab>"
    end
  end

  _G.completions = function()
    if fn.pumvisible() == 1 then
      if fn.complete_info()["selected"] ~= -1 then
        return fn["compe#confirm"] "<CR>"
      end
    end
    return t "<CR>"
  end

  -- FIXME: pular placeholder não funciona
  _G.vsnip_next = function()
    if fn.call("vsnip#jumpable", { 1 }) == 1 then
      return t "<Plug>(vsnip-jump-next)"
    end
    return t "<CR>"
  end

  _G.vsnip_prev = function()
    if fn.call("vsnip#jumpable", { -1 }) == 1 then
      return t "<Plug>(vsnip-jump-prev)"
    end
    return t "<CR>"
  end

  local inoremap = mm.inoremap
  local opts = { expr = true, silent = true }

  inoremap("<Tab>", "v:lua.tab_complete()", opts)
  inoremap("<S-Tab>", "v:lua.s_tab_complete()", opts)
  inoremap("<CR>", "v:lua.completions()", opts)
  inoremap("<C-j>", "v:lua.vsnip_next()", opts)
  inoremap("<C-k>", "v:lua.vsnip_prev()", opts)
  inoremap("<C-Space>", "compe#complete()", opts)
  inoremap("<C-e>", "compe#close()", opts)
  --]]

  --[[
  local imap = mm.imap
  local smap = mm.smap
  local inoremap = mm.inoremap
  local opts = { expr = true, silent = true }

  inoremap('<C-e>', 'compe#complete()', opts)
  imap('<Tab>', 'v:lua.__tab_complete()', opts)
  smap('<Tab>', 'v:lua.__tab_complete()', opts)
  imap('<S-Tab>', 'v:lua.__s_tab_complete()', opts)
  smap('<S-Tab>', 'v:lua.__s_tab_complete()', opts)
  inoremap('<C-f>', "compe#scroll({ 'delta': +4 })", opts)
  inoremap('<C-d>', "compe#scroll({ 'delta': -4 })", opts)
  --]]
end
return M
