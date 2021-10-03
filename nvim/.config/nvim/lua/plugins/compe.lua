-------------------------------------------------------------------------------
-- Nvim-Cmp:
-------------------------------------------------------------------------------

local t = mm.replace_termcodes
local check_back_space = mm.check_back_space

local status_cmp_ok, cmp = pcall(require, "cmp")
if not status_cmp_ok then
  return
end

local status_luasnip_ok, luasnip = pcall(require, "luasnip")
if not status_luasnip_ok then
  return
end

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-y>"] = cmp.mapping.confirm { select = true },
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(t "<C-n>", "n")
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(t "<Plug>luasnip-expand-or-jump", "")
      elseif check_back_space() then
        vim.fn.feedkeys(t "<Tab>", "n")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(t "<C-p>", "n")
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(t "<Plug>luasnip-jump-prev", "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "luasnip" },
    { name = "nvim_lua" },
    { name = "path" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = mm.lsp.item_kind[vim_item.kind] .. " (" .. vim_item.kind .. ")"
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]",
      })[entry.source.name]
      return vim_item
    end,
  },
}
