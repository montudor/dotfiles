-- space on top
vim.g.mapleader = " "

-- basic
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>ps", vim.cmd.S)
vim.keymap.set("n", "<leader>pw", vim.cmd.W)
vim.keymap.set("n", "<leader>q", vim.cmd.Q)

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear highlights" })

-- splits
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
vim.keymap.set("n", "<leader>sc", "<cmd>close<CR>", { desc = "Close split" })

-- tabs
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "Close other tabs" })
vim.keymap.set("n", "<leader>tl", "<cmd>tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>th", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
