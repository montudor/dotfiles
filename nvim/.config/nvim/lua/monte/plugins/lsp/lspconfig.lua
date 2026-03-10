return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local kotlin_handler = require("monte.plugins.lsp.util.kotlin")

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*`
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Go to next diagnostic"
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Show documentation for what is under cursor"
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local angular_node_modules = vim.fn.stdpath("data") .. "/mason/packages/angular-language-server/node_modules"
		local angular_probe_path = angular_node_modules .. "/@angular/language-server/node_modules"
		local vue_plugin_path = vim.fn.stdpath("data")
			.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		vim.lsp.config("angularls", {
			cmd = {
				"ngserver",
				"--stdio",
				"--tsProbeLocations",
				angular_node_modules,
				"--ngProbeLocations",
				angular_probe_path,
			},
			root_markers = { "angular.json", "project.json", "nx.json" },
		})

		vim.lsp.config("vue_ls", {
			filetypes = { "vue" },
			root_markers = { "package.json", "nx.json", "vue.config.js" },
			init_options = {
				vue = {
					hybridMode = false,
				},
			},
		})

		vim.lsp.config("ts_ls", {
			filetypes = {
				"typescript",
				"javascript",
				"javascriptreact",
				"typescriptreact",
				"typescript.tsx",
			},
			root_markers = { "package.json", "nx.json", "tsconfig.json" },
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = vue_plugin_path,
						languages = { "vue" },
					},
				},
			},
		})

		vim.lsp.config("graphql", {
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		})

		vim.lsp.config("emmet_ls", {
			filetypes = {
				"html",
				"htmlangular",
				"typescriptreact",
				"javascriptreact",
				"css",
				"sass",
				"scss",
				"less",
				"svelte",
				"vue",
			},
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					-- recognise vim
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
					hint = { enable = true },
				},
			},
		})

		-- Currently disabled in favour of kotlin_lsp
		-- vim.lsp.config("kotlin_language_server", {
		-- 	root_markers = { "build.gradle.kts", "settings.gradle.kts", "pom.xml", ".git" },
		-- 	filetypes = { "kotlin", "kt", "kts" },
		-- 	init_options = {
		-- 		storagePath = vim.fn.resolve(vim.fn.stdpath("cache") .. "/kotlin_language_server"),
		-- 	},
		-- 	settings = kotlin_handler.legacy_kotlin_language_server_settings(),
		-- })

		-- We don't enable all servers by default
		-- JDTLS handles its own activation
		-- rust_analyzer is currently handled by rust.lua
		for _, server_name in ipairs({
			"angularls",
			"bashls",
			"cssls",
			"emmet_ls",
			"graphql",
			"html",
			-- "kotlin_language_server",
			"lua_ls",
			"pyright",
			"tailwindcss",
			"ts_ls",
			"vue_ls",
		}) do
			vim.lsp.enable(server_name)
		end
	end,
}
