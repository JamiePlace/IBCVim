vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", "<cmd>Neotree<CR>")
-- paste and copy from clipboard
vim.keymap.set("n", "<leader>pl", '"*p')
vim.keymap.set("n", "<leader>yy", '"*y')
-- vim.keymap.set('n', '<leader>sv', vim.cmd('source $MYVIMRC'))
vim.api.nvim_set_keymap("n", "<leader>rl", "<cmd>lua ReloadConfig()<CR>", { noremap = true, silent = false })

vim.keymap.set('n', '<C-p>', function()
    require('iron.core').send(nil, string.char(13))
end)

vim.keymap.set('v', '<C-p>', function()
    require('iron.core').send(nil, string.char(13))
end)

vim.keymap.set('n', '<C-o>', function()

    local last_line = vim.fn.line('$')
    local pos = vim.api.nvim_win_get_cursor(0)
    
    require('iron.core').send_line()
    vim.notify("Sent line to repl!", vim.log.levels.INFO)
    vim.api.nvim_win_set_cursor(0, { math.min(pos[1] + 1, last_line), pos[2] })

end)
vim.keymap.set('v', '<C-o>', function()

    local last_line = vim.fn.line('$')
    local pos = vim.api.nvim_win_get_cursor(0)
    
    require('iron.core').visual_send()
    vim.notify("Sent selection to repl!", vim.log.levels.INFO)
    vim.api.nvim_win_set_cursor(0, { math.min(pos[1] + 1, last_line), pos[2] })

end)

vim.keymap.set('n', '<C-q>', "<C-o><C-p>")
vim.keymap.set('v', '<C-q>', "<C-o><C-p>")

-- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
vim.keymap.set('t', "<Esc>", "<C-\\><C-n>")
-- Code Runner
vim.keymap.set('n', '<leader>rr', '<cmd>RunCode<cr>')
