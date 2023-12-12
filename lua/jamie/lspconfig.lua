-- See: https://github.com/neovim/nvim-lspconfig/tree/54eb2a070a4f389b1be0f98070f81d23e2b1a715#suggested-configuration
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local root_files = {
	'pyproject.toml',
	'setup.py',
	'setup.cfg',
	'requirements.txt',
	'Pipfile',
	'pyrightconfig.json',
	'.git',
}

local function organize_imports()
	local params = {
		command = 'pyright.organizeimports',
		arguments = { vim.uri_from_bufnr(0) },
	}
	vim.lsp.buf.execute_command(params)
end

local function set_python_path(path)
	local clients = vim.lsp.get_active_clients {
		bufnr = vim.api.nvim_get_current_buf(),
		name = 'pyright',
	}
	for _, client in ipairs(clients) do
		client.config.settings = vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
		client.notify('workspace/didChangeConfiguration', { settings = nil })
	end
end
local util = require 'lspconfig.util'
require"lspconfig".pyright.setup{
	on_attach=on_attach,
	cmd = { 'pyright-langserver', '--stdio' },
	filetypes = { 'python' },
	root_dir = function(fname)
		return util.root_pattern(unpack(root_files))(fname)
	end,
	single_file_support = true,
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = 'openFilesOnly',
			},
		},
	},
	commands = {
		PyrightOrganizeImports = {
			organize_imports,
			description = 'Organize Imports',
		},
		PyrightSetPythonPath = {
			set_python_path,
			description = 'Reconfigure pyright with the provided python path',
			nargs = 1,
			complete = 'file',
		},
	},
	docs = {
		description = [[
	https://github.com/microsoft/pyright

	`pyright`, a static type checker and language server for python
		]],
	},
}

vim.g.python3_host_prog = set_python_path(1)
