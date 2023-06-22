vim.api.nvim_create_user_command("FilePath", function()
  print(vim.fn.expand("%:p"))
end, {})

-- vim.api.nvim_create_user_command("TrailingWhitespace", function()
--   vim.cmd("%s/\\s\\+$//e")
--   vim.cmd("nohl")
-- end, {})
