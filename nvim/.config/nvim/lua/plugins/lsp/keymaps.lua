local M = {}

M.on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
  nmap("<leader>cf", vim.lsp.buf.format, "[F]ormat")
  nmap("<leader>cl", "<cmd>LspInfo<CR>", "Lsp Info")

  nmap("[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
  nmap("]d", vim.diagnostic.goto_prev, "Next Diagnostic")
  nmap("gl", vim.diagnostic.open_float, "[L]ine Diagnostic")

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  -- nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  -- nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  -- nmap("gT", vim.lsp.buf.type_definition, "[G]oto [T]ype Definition")
  --
  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help)

  -- Lesser used LSP functionality
  -- nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  -- nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  -- nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  -- nmap("<leader>wl", function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, "[W]orkspace [L]ist Folders")

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

return M
