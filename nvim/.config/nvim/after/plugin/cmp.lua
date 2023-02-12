local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

local lspkind_status_ok, lspkind = pcall(require, "lspkind")
if not lspkind_status_ok then
  return
end

vim.opt.completeopt = { "menu", "menuone", "noselect" }

require("luasnip.loaders.from_lua").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load()

luasnip.config.set_config {
  histoty = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
}

vim.keymap.set({ "i" }, "<c-y>", function()
  if luasnip.choice_active() then
    luasnip.change_choice()
  end
end)

vim.keymap.set({ "i", "s" }, "<c-n>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-p>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end, { silent = true })

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
  },
  formatting = {
    format = lspkind.cmp_format {
      menu = {
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        luasnip = "[LuaSnip]",
        buffer = "[Buffer]",
        path = "[Path]",
      },
    },
  },
  completion = { keyword_length = 3 },
  sources = cmp.config.sources {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    {
      name = "buffer",
      option = { keyword_pattern = [[\k\+]] },
      keyword_length = 3
    },
    { name = "path" },
    { name = "nvim_lua" },
    { name = "neorg" },
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
}
