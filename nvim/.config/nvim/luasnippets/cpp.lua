local ls = require('luasnip')

local cpp_main = [[
int	main(int argc, const char **argv)
{
	$0
	return (0);
}
]]

local cpp_class = [[
class $1 {
public:
    $0
};
]]

ls.add_snippets('cpp', {
  ls.parser.parse_snippet({ trig = 'main', dscr = 'Standard main function' }, cpp_main),
  ls.parser.parse_snippet({ trig = 'class' }, cpp_class),
})
