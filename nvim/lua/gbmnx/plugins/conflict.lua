return {
	"niekdomi/conflict.nvim",
	config = function()
		require("conflict").setup({
			default_mappings = {
				current = "<leader>cc",
				incoming = "<leader>ci",
				both = "<leader>cb",
				base = "<leader>cB",
				none = false,
				next = "]x",
				prev = "[x",
			},
			show_actions = true, -- Show clickable [Accept Current | ...] labels
			disable_diagnostics = true, -- Disable LSP/Diagnostics while conflicts exist
			highlights = {
				-- Names of highlight groups to use for sections
				current = "DiffText",
				incoming = "DiffAdd",
				ancestor = "DiffChange",
			},
		})
	end,
}
