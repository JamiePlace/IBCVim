local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    -- theme
    {"ellisonleao/gruvbox.nvim" },
    -- treesitter
    {"nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {  "lua", "vim", "python", "r", "rust" },
            sync_install = false,
            highlight = { enable = true , additional_vim_regex_highlighting = false},
        })
    end
},
{"nvim-treesitter/nvim-treesitter-context"};
-- lsp
{'VonHeikemen/lsp-zero.nvim',
branch = 'v1.x',
dependencies = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-path'},
    {'saadparwaiz1/cmp_luasnip'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-nvim-lua'},

    -- Snippets
    {'L3MON4D3/LuaSnip'},
    {'rafamadriz/friendly-snippets'},
}
    },
    { "williamboman/mason.nvim" },
    -- fugitive "git"
    {"tpope/vim-fugitive"},
    -- telescope "fuzzy finder"
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    -- autopairs
    {
        "windwp/nvim-autopairs", event="InsertEnter", opts = {},
        config = function()
            require('nvim-autopairs').setup({ })
        end
    },
    -- copilot
    {"github/copilot.vim"},
    -- csv
    {'mechatroner/rainbow_csv'},
})


