return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				vue = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				htmlangular = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
			formatters = {
				prettier = {
					exe = "prettier",
					args = { "--stdin-filepath", "$FILENAME" },
					stdin = true,
					cwd = require("conform.util").root_file({
						"package.json",
						"prettier.config.js",
						"prettier.config.mjs",
						".prettierrc",
						".prettierignore",
						".editorconfig",
						".git",
					}),
					require_cwd = true,
				},
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				bufnr = vim.api.nvim_get_current_buf(),
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
