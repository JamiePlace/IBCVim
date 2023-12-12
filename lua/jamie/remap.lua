vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Neotree)
--vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

--paste and copy from clipboard
vim.keymap.set("n", "<leader>pl", '"*p')
vim.keymap.set("n", "<leader>yl", '"*y')
vim.keymap.set("v", "<leader>pl", '"*p')
vim.keymap.set("v", "<leader>yl", '"*y')
-- vim.keymap.set('n', '<leader>sv', vim.cmd('source $MYVIMRC'))
-- Code Runner
vim.keymap.set("i", "<C-c>", "<Esc>")

-- jump to previous buffer
vim.keymap.set("n", "<leader>ll", "<C-6>")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
