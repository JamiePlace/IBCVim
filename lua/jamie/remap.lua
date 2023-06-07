vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", "<cmd>Neotree<CR>")
-- paste and copy from clipboard
vim.keymap.set("n", "<leader>pl", '"*p')
vim.keymap.set("n", "<leader>yy", '"*y')
vim.keymap.set("v", "<leader>pl", '"*p')
vim.keymap.set("v", "<leader>yy", '"*y')
-- vim.keymap.set('n', '<leader>sv', vim.cmd('source $MYVIMRC'))
vim.api.nvim_set_keymap("n", "<leader>rl", "<cmd>lua ReloadConfig()<CR>", { noremap = true, silent = false })
-- Code Runner
vim.keymap.set('n', '<leader>pr', '<cmd>RunCode<cr>')
vim.keymap.set("i", "<C-c>", "<Esc>")
