local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
  return
end

indent_blankline.setup {
  char = "│", -- ┆ ┊ 
  show_foldtext = false,
  show_trailing_blankline_indent = false,
  show_current_context = true,
  show_current_context_start = false,
  show_first_indent_level = true,
  use_treesitter = false,
  buftype_exclude = { "terminal", "nofile" },
  context_patterns = {
    "^for",
    "^if",
    "^object",
    "^table",
    "^while",
    "arguments",
    "block",
    "catch_clause",
    "class",
    "else_clause",
    "for",
    "function",
    "if_statement",
    "import_statement",
    "jsx_element",
    "jsx_self_closing_element",
    "list_literal",
    "method",
    "operation_type",
    "return",
    "selector",
    "try_statement",
    "while",
  },
  filetype_exclude = {
    "help",
    "startify",
    "dashboard",
    "packer",
    "neogitstatus",
    "NvimTree",
    "Trouble",
    "man",
    "norg",
  },
}
