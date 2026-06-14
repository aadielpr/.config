return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				-- LSP servers
                "tsgo",
				"lua-language-server",
				"gopls",
				"python-lsp-server",
				"clangd",
                "html-lsp",
				-- Formatters
				"prettierd",
				"stylua",
			},
		})
	end,
}
