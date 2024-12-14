return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	config = function()
		local bufferline = require("bufferline")

		local function filter_current_and_unsaved(buf_number, _)
			local current_buf = vim.api.nvim_get_current_buf()

			if buf_number == current_buf or vim.bo[buf_number].modified then
				return true
			end

			for _, win in ipairs(vim.api.nvim_list_wins()) do
				if vim.api.nvim_win_get_buf(win) == buf_number then
					return true
				end
			end

			return false
		end

		bufferline.setup({
			options = {
				mode = "buffers",
				style_preset = bufferline.style_preset.minimal,
				numbers = "none",
				indicator_icon = "|", -- or "▎"
				buffer_close_icon = "",
				modified_icon = "●",
				close_icon = "",
				show_close_icon = false,
				show_buffer_close_icons = false,
				offsets = {
					{
						filetype = "NvimTree",
						text = "",
						highlight = "Directory",
						separator = true,
					},
				},
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local icon = level:match("error") and " " or " "
					local color = level:match("error") and "%#DiagnosticError#" or "%#DiagnosticWarn#"

					return color .. icon .. count .. "%*"
				end,
				custom_filter = filter_current_and_unsaved,
			},
		})
	end,
}
