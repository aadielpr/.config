return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local mason_lsp = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local border = require("gbmnx.utils.border").border_chars_square
		local map = require("gbmnx.utils.map").map

		mason_lsp.setup()

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("gbmnx_lsp_attach", { clear = true }),
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client then
					client.server_capabilities.semanticTokensProvider = nil
				end
				local opts = { noremap = true, silent = true, buffer = event.buf }

				map("n", "gD", vim.lsp.buf.declaration, opts)
				-- map("n", "gd", vim.lsp.buf.definition, opts)
				map("n", "gi", vim.lsp.buf.implementation, opts)
				map("n", "K", function()
					vim.lsp.buf.hover({
						border = border,
						max_width = 70,
						max_height = 15,
					})
				end, opts)
				map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				map("n", "<leader>rn", vim.lsp.buf.rename, opts)
				map("i", "<C-h>", function()
					vim.lsp.buf.signature_help({
						border = border,
						max_width = 70,
						max_height = 15,
					})
				end, opts)
				map("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "gd", function()
					local client = vim.lsp.get_clients({ bufnr = 0 })[1]
					if not client then
						return
					end

					local encoding = client.offset_encoding or "utf-16"

					client:request(
						"textDocument/definition",
						vim.lsp.util.make_position_params(0, encoding),
						function(err, result)
							if err or not result then
								return
							end

							local location = vim.islist(result) and result[1] or result
							vim.lsp.util.show_document(location, encoding, { focus = true })
						end,
						0
					)
				end, { desc = "Go to first definition" })

				-- diagnostic
				map("n", "E", vim.diagnostic.open_float, opts)
				map("n", ".d", vim.diagnostic.goto_next, opts)
				map("n", ",d", vim.diagnostic.goto_prev, opts)
			end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		-- Diagnostic
		vim.diagnostic.config({
			virtual_text = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰌵 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
			float = {
				focusable = true,
				border = border,
				source = "always",
				max_width = 70,
				max_height = 15,
				header = "",
				prefix = "",
			},
		})
	end,
}
