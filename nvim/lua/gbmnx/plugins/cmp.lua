return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
		"windwp/nvim-autopairs",
		"onsails/lspkind.nvim",
	},
	config = function()
		local ls = require("luasnip")
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		lspkind.init({ mode = "symbol", preset = "codicons" })
		-- local npairs = require("nvim-autopairs")

		vim.opt.completeopt = { "menu", "menuone", "noselect" }

		-- npairs.setup({ enable_check_bracket_line = false })

		cmp.setup({
			window = {
				completion = cmp.config.window.bordered({ border = "single", scrollbar = false }),
				documentation = cmp.config.window.bordered({ border = "single" }),
			},
			formatting = {
				fields = { "icon", "abbr" },
				format = lspkind.cmp_format({}),
			},
			snippet = {
				expand = function(args)
					ls.lsp_expand(args.body)
				end,
			},
			mapping = {
				["<Esc>"] = cmp.mapping.close(),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-y>"] = cmp.config.disable,
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "buffer" },
			},
			sorting = {
				priority_weight = 2,
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,
					cmp.config.compare.locality,
					cmp.config.compare.sort_text,
					cmp.config.compare.kind,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
		})
	end,
}
