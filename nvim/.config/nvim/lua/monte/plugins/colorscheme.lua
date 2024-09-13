--return {
--	"folke/tokyonight.nvim",
--	priority = 1000,
--	config = function()
--		vim.cmd("colorscheme tokyonight")
--	end,
--}

return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		transparent_background = false,
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd("colorscheme catppuccin-mocha")
		-- vim.o.pumblend = 0
		-- vim.o.winblend = 0
	end,
}
