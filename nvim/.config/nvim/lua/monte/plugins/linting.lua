return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		-- local util = require("lspconfig/util")

		-- lint.linters.eslint_d = {
		-- 	name = "eslint_d",
		-- 	cmd = "eslint_d",
		-- 	stdin = true,
		-- 	args = { "--stdin", "--stdin-filename", "%filepath", "--format", "json" },
		-- 	stream = "both",
		-- 	ignore_exitcode = true,
		-- 	parser = require("lint.linters.eslint_d").parser,
		-- }

		lint.linters.pylint = {
			name = "pylint",
			cmd = "python3",
			stdin = true,
			args = {
				"-m",
				"pylint",
				"-f",
				"json",
				"--from-stdin",
				function()
					return vim.api.nvim_buf_get_name(0)
				end,
			},
			stream = "stderr",
			ignore_exitcode = true,
			parser = require("lint.linters.pylint").parser,
		}

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			-- python = { "pylint" },
		}

		-- lint.linters.pylint.cmd = "python3"
		-- lint.linters.pylint.args = { "-m", "pylint", "-f", "json" }

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		local get_lsp_client = function()
			local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
			local clients = vim.lsp.get_active_clients()
			if next(clients) == nil then
				return nil
			end

			for _, client in ipairs(clients) do
				local filetypes = client.config.filetypes
				if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
					return client
				end
			end

			return nil
		end

		local function perform_lint()
			-- local get_clients = vim.lsp.buf_get_clients
			-- local clients = get_clients()

			-- local root_dir = nil
			-- for _, client in ipairs(clients) do
			-- 	print("Client: ".. client.name)
			-- 	if client.root_dir then
			-- 		print("Using root_dir: ".. client.root_dir)
			-- 		root_dir = client.root_dir
			-- 		break
			-- 	end
			-- end

			local root_dir = nil
			local client = get_lsp_client()

			if client then
				root_dir = client.root_dir
				-- print("Using root_dir: ".. root_dir)
			end

			if not root_dir then
				root_dir = vim.fn.getcwd()
				-- print("Warning: root_dir not found, using " .. root_dir)
			end

			lint.try_lint(nil, { cwd = root_dir })
		end

		vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				vim.schedule(function()
					perform_lint()
				end)
			end,
		})

		vim.keymap.set("n", "<leader>ll", function()
			perform_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
