return {
  -- Indent Guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "│", tab_char = "│" },
      scope = { enabled = true, show_start = false, },
      whitespace = { highlight = { "Whitespace", "NonText" } },
    }
  }
}
