local ok, auto_session = pcall(require, "auto-session")
if not ok then
  return
end

auto_session.setup {
  log_level = "info",
  auto_restore_enabled = false,
  -- auto_session_suppress_dirs = { "~/", "~/Projects" },
}
