local ls = require('luasnip')

ls.add_snippets('go', {
  ls.parser.parse_snippet(
    { trig = 'ec', dscr = 'Error checking' },
    [[
if err != nil {
	return err
}
]]
  ),
})
