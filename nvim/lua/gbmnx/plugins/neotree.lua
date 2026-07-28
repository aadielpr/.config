return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		local neotree = require("neo-tree")
		local map = require("gbmnx.utils.map").map

		neotree.setup({
			close_if_last_window = true,
			event_handlers = {
				{
					event = "neo_tree_window_after_open",
					handler = function()
						vim.wo.number = false
						vim.wo.relativenumber = false
						vim.wo.statuscolumn = ""
						vim.wo.fillchars = "eob: "
					end,
				},
			},
			filesystem = {
				filtered_items = {
					visible = true,
					show_hidden_count = false,
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_by_name = {
						-- '.git',
						".DS_Store",
					},
					never_show = { ".DS_Store", ".git" },
				},
			},
			window = {
				position = "left",
				width = 40,
				mappings = {
					["<BS>"] = "close_node",
				},
			},
			default_component_configs = {
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				git_status = {
					symbols = {
						added = " ",
						modified = " ",
						deleted = " ",
						renamed = "󰁕", -- renamed
						untracked = "", -- untracked
						unstaged = "u", -- unstaged changes
						staged = "", -- staged
						conflict = "", -- conflict
					},
				},
			},
		})

map("n", "<leader>e", ":Neotree toggle=true<CR>", { silent = true, noremap = true })
	end,
}
