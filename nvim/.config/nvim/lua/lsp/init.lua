-------------------------------------------------------------------------------
--  LSP:
-------------------------------------------------------------------------------

-- Populate global escope
require "lsp.common"

mm.nnoremap("<leader>i", "<cmd>LspInfo<CR>")

local lsp = vim.lsp

local function setup_diagnostic_signs()
  for type, icon in pairs(mm.lsp.signs) do
    local hl = "LspDiagnosticsSign" .. type
    vim.fn.sign_define(hl, {
      text = icon,
      texthl = hl,
      numhl = hl,
    })
  end
end

local function on_publish_show_diagnostic_sources(_, _, params, client_id, _, config)
  local uri = params.uri
  local bufnr = vim.uri_to_bufnr(uri)

  if not bufnr then
    return
  end

  local diagnostics = params.diagnostics

  vim.lsp.diagnostic.save(diagnostics, bufnr, client_id)

  if not vim.api.nvim_buf_is_loaded(bufnr) then
    return
  end

  -- don't mutate the original diagnostic because it would interfere with
  -- code action (and probably other stuff, too)
  local prefixed_diagnostics = vim.deepcopy(diagnostics)
  for i, v in pairs(diagnostics) do
    prefixed_diagnostics[i].message = string.format("%s: %s", v.source, v.message)
  end
  vim.lsp.diagnostic.display(prefixed_diagnostics, bufnr, client_id, config)
end

local function setup_handlers()
  lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(
    -- lsp.diagnostic.on_publish_diagnostics,
    on_publish_show_diagnostic_sources,
    mm.lsp.diagnostic_opts
  )
  lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, mm.lsp.popup_opts)
  lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, mm.lsp.popup_opts)
end

local function add_format_on_save()
  if mm[vim.bo.filetype].lsp.format_on_save == true then
    vim.cmd "autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync()"
  end
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
local function avoid_formatting_conflicts(client)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
end

local function add_document_highlight(client)
  if mm[vim.bo.filetype].lsp.document_highlight == false then
    return
  end

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local function add_lsp_keybindings(bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = { buffer = bufnr }
  mm.nnoremap("[d", "<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = mm.lsp.popup_opts})<CR>", opts)
  mm.nnoremap("]d", "<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = mm.lsp.popup_opts})<CR>", opts)

  -- Whick-Key
  local local_opts = {
    mode = "n", -- NORMAL mode
    prefix = "<localleader>",
    buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local local_mappings = {
    name = "LSP",
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    a = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
    s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help" },
    d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition" },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Formatting" },
    D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration" },
    R = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
    c = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation" },
    l = { "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics(mm.lsp.popup_opts)<cr>", "Line diagnostics" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
  }

  local wk = require "which-key"
  wk.register(local_mappings, local_opts)
end

local function on_attach(client, bufnr)
  avoid_formatting_conflicts(client)
  setup_diagnostic_signs()
  setup_handlers()
  add_format_on_save()
  add_document_highlight(client)
  add_lsp_keybindings(bufnr)
end

local function merge_user_settings(config, server)
  local ok, user_settings = pcall(require, "lsp.settings." .. server)
  if ok then
    return vim.tbl_extend("force", config, user_settings)
  end
  return config
end

local function make_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.documentationFormat = {
    "markdown",
    "plaintext",
  }
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.preselectSupport = true
  capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
  capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
  capabilities.textDocument.completion.completionItem.deprecatedSupport = true
  capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
  capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  return capabilities
end

local function make_config(server)
  local capabilities = make_capabilities()

  local default_config = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }
  return merge_user_settings(default_config, server)
end

local function setup_servers()
  require("lspinstall").setup()
  require("lsp.null-ls").setup()

  -- get all installed servers
  local servers = require("lspinstall").installed_servers()

  for _, server in pairs(servers) do
    local config = make_config(server)
    require("lspconfig")[server].setup(config)
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require("lspinstall").post_install_hook = function()
  setup_servers() -- reload installed servers
  vim.cmd "bufdo e"
end
