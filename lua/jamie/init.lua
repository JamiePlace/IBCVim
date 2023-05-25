require("jamie.remap")
require("jamie.set")
require("jamie.packer")
require("jamie.reload")
require("jamie.python")

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- python path
vim.g.python3_host_prog = PYTHON_ENV .. "/Scripts/python.exe"
vim.g.python = PYTHON_ENV .. "/Scripts/python.exe"
vim.g.python_style = 'numpy'
