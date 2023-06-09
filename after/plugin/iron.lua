local iron = require("iron.core")
local view = require("iron.view")

iron.setup {
    config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        -- Your repl definitions come here
        repl_definition = {
            python = {
                command = {PYTHON_ENV .. "/Scripts/ipython3.exe"}
            } 
        },
        -- How the repl window will be displayed
        -- See below for more information
        repl_open_cmd = view.split.rightbelow("40%")
    },
    -- Iron doesn't set keymaps by default anymore.
    -- You can set them here or manually add keymaps to the functions in iron.core
    keymaps = {
        --send_motion = "<space>sc",
        --visual_send = "<space>sc",
        send_file = "<space>sf",
        send_line = "<space>sc",
        send_mark = "<space>sm",
        mark_motion = "<space>mc",
        mark_visual = "<space>mc",
        remove_mark = "<space>md",
        --cr = "<C-e>",
        interrupt = "<space>s<space>",
        exit = "<space>sq",
        clear = "<space>cl",
    },
    -- If the highlight is on, you can change how it looks
    -- For the available options, check nvim_set_hl
    highlight = {
        italic = true
    },
    ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

vim.keymap.set('n', '<C-i>', function()
    require('iron.core').send(nil, string.char(13))
end)

vim.keymap.set('i', '<C-i>', function()
    require('iron.core').send(nil, string.char(13))
end)


vim.keymap.set('v', '<C-i>', function()
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

vim.keymap.set('i', '<C-o>', function()

    local last_line = vim.fn.line('$')
    local pos = vim.api.nvim_win_get_cursor(0)

    require('iron.core').visual_send()
    vim.notify("Sent selection to repl!", vim.log.levels.INFO)
    vim.api.nvim_win_set_cursor(0, { math.min(pos[1] + 1, last_line), pos[2] })

end)

vim.keymap.set('n', '<C-p>', function()

    local last_line = vim.fn.line('$')
    local pos = vim.api.nvim_win_get_cursor(0)

    require('iron.core').visual_send()
    vim.notify("Sent selection to repl!", vim.log.levels.INFO)
    vim.api.nvim_win_set_cursor(0, { math.min(pos[1] + 1, last_line), pos[2] })
    require('iron.core').send(nil, string.char(13))
    vim.notify("Executed in repl!", vim.log.levels.INFO)
end)

-- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
vim.keymap.set('t', "<C-c>", "<C-\\><C-n>")
