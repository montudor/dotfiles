-- space on top
vim.g.mapleader = " "

-- clear highlights
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear highlights" })

-- move lines
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line selection up" })

-- splits
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
vim.keymap.set("n", "<leader>sc", "<cmd>close<CR>", { desc = "Close split" })

-- tabs
vim.keymap.set("n", "<leader>ztn", "<cmd>tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>ztc", "<cmd>tabclose<CR>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>zto", "<cmd>tabonly<CR>", { desc = "Close other tabs" })
vim.keymap.set("n", "<leader>ztl", "<cmd>tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>zth", "<cmd>tabprevious<CR>", { desc = "Previous tab" })

-- inlay hints
if vim.lsp.inlay_hint then
	vim.keymap.set("n", "<leader>uh", function()
		local scope = { bufnr = 0 }
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(scope), scope)
	end, { desc = "Toggle inlay hints" })
end
