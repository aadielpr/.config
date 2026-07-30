local active = "bono"

return {
	{
		dir = "~/gbmnx/dev/melange-nvim",
		lazy = active ~= "melange",
		priority = 1000,
		config = function()
			vim.g.melange_enable_font_variants = {
				bold = true,
				italic = false,
				underline = false,
				undercurl = false,
				strikethrough = true,
			}

			vim.cmd("colorscheme melange")
		end,
	},
	{
		"ThorstenRhau/token",
		lazy = active ~= "token",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("token")
		end,
	},
	{
		"aadielpr/bono.nvim",
		lazy = active ~= "bono",
		priority = 1000,
		config = function()
            require("bono").setup({
                variant = "cream"
            })

			vim.cmd.colorscheme("bono")
		end,
	},
}
