vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- vim.keymap.set('n', '<leader>sv', vim.cmd('source $MYVIMRC'))
vim.api.nvim_set_keymap("n", "<leader>rl", "<cmd>lua ReloadConfig()<CR>", { noremap = true, silent = false })

vim.keymap.set('n', '<C-h>', function()

    local last_line = vim.fn.line('$')
    local pos = vim.api.nvim_win_get_cursor(0)
    
    require('iron.core').send_line()
    vim.notify("Sent line to repl!", vim.log.levels.INFO)
    vim.api.nvim_win_set_cursor(0, { math.min(pos[1] + 1, last_line), pos[2] })

    require('iron.core').send(nil, string.char(13))
end)
vim.keymap.set('v', '<C-h>', function()

    local last_line = vim.fn.line('$')
    local pos = vim.api.nvim_win_get_cursor(0)
    
    require('iron.core').visual_send()
    vim.notify("Sent selection to repl!", vim.log.levels.INFO)
    vim.api.nvim_win_set_cursor(0, { math.min(pos[1] + 1, last_line), pos[2] })

end)
vim.keymap.set('n', '<C-n>', function()
    require('iron.core').send(nil, string.char(13))
end)
-- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
vim.keymap.set('t', "<Esc>", "<C-\\><C-n>")

