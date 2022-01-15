local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

nnoremap("<F2>", "<cmd>TSHighlightCapturesUnderCursor<CR>")
nnoremap("<F3>", "<cmd>TSPlaygroundToggle<CR>")

configs.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = { "bash", "c", "comment", "cpp", "lua", "python", "query" },
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" },
  highlight = {
    enable = true,
    disable = { "" },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<TAB>",
      -- scope_incremental = "grc",
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },
}
