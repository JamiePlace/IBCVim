require("jamie.remap")
require("jamie.set")
require("jamie.packer")
require("jamie.reload")
require("jamie.python")

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

GIT_ROOT_DIR = function()
    return vim.fn.getcwd()
end

CURRENT_FILE_PATH = function()
    return vim.api.nvim_buf_get_name(0)
end
