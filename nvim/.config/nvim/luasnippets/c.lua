local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local i = ls.insert_node

ls.add_snippets("c", {
  s(
    { trig = "while42", dscr = "While formatted for École 42" },
    fmt( -- The snippet code actually looks like the equation environment it produces.
      [[
        while (<>)
        {
        	<>
        }
      ]],
      { i(1, "expression"), i(2) },
      { delimiters = "<>" }
    )
  ),
})
