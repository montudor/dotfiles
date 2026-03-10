return {
	"mason-org/mason.nvim",
	dependencies = {
		{ "mason-org/mason-lspconfig.nvim" },
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			dependencies = { "mason-org/mason.nvim" },
		},
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
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

		mason_lspconfig.setup({
			automatic_enable = false,
			ensure_installed = {
				-- JS and co. :(
				"ts_ls",
				"angularls",
				"vue_ls",
				"html",
				"cssls",
				"tailwindcss",
				"emmet_ls",
				"graphql",

				-- Python
				"pyright",
				-- "ruff_lsp",

				-- Lua
				"lua_ls",

				-- Rust
				"rust_analyzer",

				-- Java
				"jdtls",

				-- Kotlin
				"kotlin_language_server",
				"kotlin_lsp",

				-- Bash
				"bashls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				-- JS
				"prettier",
				"eslint_d",

				-- Lua
				"stylua",

				-- Python
				"black",
				"isort",
				"pylint",
				"debugpy",

				-- Rust
				"codelldb",

				-- Java
				"java-debug-adapter",
				"java-test",
			},
		})
	end,
}
