local ok, presence = pcall(require, "presence")
if not ok then
  return
end

presence:setup({
  -- auto_update = false,
})
