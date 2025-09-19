return {
	-- TODO: update to v2
	"williamboman/mason.nvim",
	version = "^1.0.0",
	dependencies = {
		{ "williamboman/mason-lspconfig.nvim", version = "^1.0.0" },
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			version = "^1.0.0",
			dependencies = { "williamboman/mason.nvim", version = "^1.0.0" },
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
			ensure_installed = {
				-- JS and co. :(
				"ts_ls",
				"angularls",
				"volar",
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
