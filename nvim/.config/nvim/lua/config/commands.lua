vim.api.nvim_create_user_command("FilePath", function()
  print(vim.fn.expand("%:p"))
end, {})
