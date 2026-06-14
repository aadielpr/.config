return {
	"L3MON4D3/LuaSnip",
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load()

		local ls = require("luasnip")

		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node

		ls.add_snippets("all", {
			s("/*", {
				t({ "/**", " * " }),
				i(1, "Your comment here"),
				t({ "", " */" }),
			}),
		})

		ls.add_snippets("go", {
			s("iferr", {
				t({ "if err != nil {", "\t" }),
				i(1, "log.Println(err)"),
				t({ "", "}" }),
			}),
		})

		ls.add_snippets(
			"html",
			{
				s("!DOCTYPE", {
					t({
						"<!DOCTYPE html>",
						'<html lang="en">',
						"<head>",
						'    <meta charset="UTF-8">',
						'    <meta name="viewport" content="width=device-width, initial-scale=1.0">',
						"    <title>",
					}),
					i(1, "Document"),
					t({
						"</title>",
						"</head>",
						"<body>",
						"",
					}),
					i(2),
					t({
						"",
						"</body>",
						"</html>",
					}),
				}),
			}
		)
	end,
}
