local active = "melange"

return {
	{
		"datsfilipe/vesper.nvim",
		lazy = active ~= "vesper",
		priority = 1000,
		config = function()
			require("vesper").setup({
				transparent = false,
				italics = {
					comments = true,
					keywords = false,
					functions = false,
					strings = false,
					variables = false,
				},
				overrides = {
					CursorLine = { bg = "#2a2a2a" },
					TelescopeSelection = { bg = "#2a2a2a" },
				},
				palette_overrides = {},
			})
			vim.cmd("colorscheme vesper")
		end,
	},
	{
		dir = "~/gbmnx/dev/melange-nvim",
		lazy = active ~= "melange",
		priority = 1000,
		config = function()
			vim.g.melange_enable_font_variants = {
				bold = true,
				italic = false,
				underline = true,
				undercurl = true,
				strikethrough = true,
			}

			vim.cmd("colorscheme melange")
		end,
	},
	{
		"oskarnurm/koda.nvim",
		lazy = active ~= "koda" ,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme koda-dark")
		end,
	},
}
