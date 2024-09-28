return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")

		local function macro_recording()
			local recording_register = vim.fn.reg_recording()
			if recording_register == "" then
				return ""
			end

			return "Recording @" .. recording_register
		end

		local function diff_source()
			local gitsigns = vim.b.gitsigns_status_dict
			if gitsigns then
				return {
					added = gitsigns.added,
					modified = gitsigns.changed,
					removed = gitsigns.removed,
				}
			end
		end

		lualine.setup({
			options = {
				theme = "catppuccin-mocha",
			},
			sections = {
				lualine_b = {
					{ "macro-recording", fmt = macro_recording },
					{ "b:gitsigns_head", icon = "" },
					{ "diff", source = diff_source },
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}
