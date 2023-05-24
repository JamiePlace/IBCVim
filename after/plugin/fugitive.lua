vim.keymap.set("n", "<leader>gs", "<cmd>Git status<cr>")
vim.keymap.set("n", "<leader>ga", "<cmd>Git add %<cr>")
vim.keymap.set("n", "<leader>gc", function()
    local message = vim.fn.input("Commit Message > ")
    local git_placeholder = "Git commit -m 'PLACEHOLDER'"
    command = string.gsub(git_placeholder, 'PLACEHOLDER', message)
    vim.cmd(command)
end)

vim.keymap.set("n", "<leader>gp", function()
    local prompt = vim.fn.input("Push? [Y]es/[N]o > ")
    prompt = string.lower(prompt)

    if prompt == 'y' then
        vim.cmd('Git push')
    else
        print('Not Pushing!')
    end
end)
