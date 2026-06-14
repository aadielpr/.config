return {
	{
		"stevearc/oil.nvim",
		lazy = false,
		config = function()
            local oil = require("oil")
			oil.setup({
				keymaps = {
					["g?"] = { "actions.show_help", mode = "n" },
					["<CR>"] = "actions.select",
					["<leader>r"] = "actions.preview",
					["<ESC>"] = { "actions.close", mode = "n" },
					["<C-l>"] = "actions.refresh",
					["<BS>"] = { "actions.parent", mode = "n" },
					["_"] = { "actions.open_cwd", mode = "n" },
					["g."] = { "actions.toggle_hidden", mode = "n" },
					["g\\"] = { "actions.toggle_trash", mode = "n" },
				},
				use_default_keymaps = false,
				win_options = {
					fillchars = "eob: ",
					number = false,
					relativenumber = false,
					signcolumn = "no",
					statuscolumn = "",
					foldcolumn = "2",
					winbar = " %{v:lua.require('oil').get_current_dir()}",
					winhighlight = "FoldColumn:NormalFloat,WinBar:NormalFloat,WinBarNC:NormalFloat",
				},
				delete_to_trash = true,
				view_options = {
					show_hidden = true,
				},
				float = {
					padding = 2,
					max_width = 0.4,
					max_height = 0.8,
					border = "none",
					win_options = {
						winblend = 0,
					},
				},
				confirmation = {
					border = "single",
					win_options = {
						winblend = 0,
					},
				},
				progress = {
					border = "single",
					win_options = {
						winblend = 0,
					},
				},
			})

			local function toggle_oil()
				-- If current window is Oil, close it
				if vim.bo.filetype == "oil" then
					vim.cmd("bd")
					return
				end

				-- Open Oil in a left split
				oil.open()
			end

			vim.keymap.set("n", "<C-p>", function()
                toggle_oil()
			end)
		end,
	},
}
