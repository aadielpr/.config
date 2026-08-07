return {
	"pablopunk/pi.nvim",
	config = function()
		require("pi").setup({
			provider = "opencode-go",
			model = "deepseek-v4-flash",
		})
	end,
}
