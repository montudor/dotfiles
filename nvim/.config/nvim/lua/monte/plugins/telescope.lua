return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-p>"] = actions.cycle_history_prev,
						["<C-n>"] = actions.cycle_history_next,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files in cwd" })
		vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Find recent/oldfiles" })
		vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		vim.keymap.set(
			"n",
			"<leader>fc",
			"<cmd>Telescope grep_string<cr>",
			{ desc = "Find string under cursor in cwd" }
		)
		vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
		vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
		vim.keymap.set("n", "<leader>fh", "<cmd>Telescope git_status<cr>", { desc = "Find git status" })
		vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Find diagnostic issues" })
		vim.keymap.set("n", "<leader>fm", "<cmd>Telescope keymaps<cr>", { desc = "Find keymaps" })
		vim.keymap.set("n", "<leader>fr", "<cmd>Telescope resume<cr>", { desc = "Resume last search" })
		vim.keymap.set("n", "<leader>fq", "<cmd>Telescope quickfix<cr>", { desc = "Find quickfix" })
		vim.keymap.set("n", "<leader>fl", "<cmd>Telescope loclist<cr>", { desc = "Find loclist" })
		vim.keymap.set("n", "<leader>fa", function()
			require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h") })
		end, { desc = "Find all relative to current file" })
	end,
}
