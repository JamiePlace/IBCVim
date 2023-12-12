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
	-- background
	{"ellisonleao/gruvbox.nvim",
		as="gruvbox"
	},
	-- treesitter
	{"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function () 
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {  "lua", "vim", "python", "r", "rust" },
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },  
			})
		end
	},
	-- neotree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		config = function()

			require("neo-tree").setup({
				close_if_last_window=false,
			})
			vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
		end
	},
	-- lsp
	{ "neovim/nvim-lspconfig" },
	-- fugitive "git"
	{"tpope/vim-fugitive"},
	-- telescope "fuzzy finder"
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		-- or                              , branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	-- python virtual env selector
	{
		'linux-cultist/venv-selector.nvim',
		dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
		opts = {
			-- Your options go here
			name = {"venv", ".venv"},
			-- auto_refresh = false
		},
		event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
		keys = {
			-- Keymap to open VenvSelector to pick a venv.
			{ '<leader>vs', '<cmd>VenvSelect<cr>' },
			-- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
			{ '<leader>vc', '<cmd>VenvSelectCached<cr>' },
		},
	},
	-- black formatter
	{"averms/black-nvim"},
})


