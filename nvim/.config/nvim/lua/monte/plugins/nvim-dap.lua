return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",

			-- Telescope integration
			"nvim-telescope/telescope.nvim",
			"nvim-telescope/telescope-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")

			require("telescope").load_extension("dap")
			require("dapui").setup()
			require("dap-go").setup()

			require("nvim-dap-virtual-text").setup({
				commented = false,
				display_callback = function(variable, buf, stackframe, node, options)
					local text = "  "
					if options.virt_text_pos == "inline" then
						text = text .. " = " .. variable.value
					else
						text = text .. variable.name .. " = " .. variable.value
					end
					return text
				end,
			})

			vim.keymap.set("n", "<leader>bb", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<leader>brc", dap.run_to_cursor, { desc = "Run to cursor" })
			vim.keymap.set("n", "<leader>bc", dap.continue, { desc = "Continue" })
			vim.keymap.set("n", "<leader>bsi", dap.step_into, { desc = "Step into" })
			vim.keymap.set("n", "<leader>bss", dap.step_over, { desc = "Step over" })
			vim.keymap.set("n", "<leader>bso", dap.step_out, { desc = "Step out" })
			vim.keymap.set("n", "<leader>bsb", dap.step_back, { desc = "Step back" })
			vim.keymap.set("n", "<leader>?", function()
				require("dapui").eval(nil, { enter = true })
			end, { desc = "Evaluate under cursor" })

			vim.keymap.set("n", "<leader>br", dap.restart, { desc = "Restart DAP" })
			vim.keymap.set("n", "<leader>bx", dap.close, { desc = "Stop DAP" })
			vim.keymap.set("n", "<leader>bu", function()
				ui.toggle()
			end, { desc = "Toggle DAP UI" })

			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				--For tests to stay open
				--ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				--For tests to stay open
				--ui.close()
			end
		end,
	},
}
