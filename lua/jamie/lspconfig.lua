local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'pylsp',
  'rust_analyzer',
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<CR>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("n", "<C-f>", function() vim.lsp.buf.format() end, opts)
end)

require('lspconfig').pylsp.setup({
	on_attach = function(client, bufnr)
		print('pylsp attached')
	end,
	settings = {
		pylsp = {
			plugins = {
				-- formatter
				black = {enabled = true},
				autopep8 = {enabled = false},
				yapf = {enabled = false},
				-- linter
				pylint = { enabled = true },
				pyflakes = { enabled = false },
				pycodestyle = { enabled = false },
				-- type checker
				pylsp_mypy = { enabled = true },
				-- auto-completion options
				jedi_completion = { fuzzy = true },
				-- import sorting
				pyls_isort = { enabled = true },
			}
		}
	}
})
-- pyright
--local util = require 'lspconfig.util'
--
--local root_files = {
--  'pyproject.toml',
--  'setup.py',
--  'setup.cfg',
--  'requirements.txt',
--  'Pipfile',
--  'pyrightconfig.json',
--  '.git',
--}
--
--local function organize_imports()
--  local params = {
--    command = 'pyright.organizeimports',
--    arguments = { vim.uri_from_bufnr(0) },
--  }
--  vim.lsp.buf.execute_command(params)
--end
--
--local function set_python_path(path)
--  local clients = vim.lsp.get_active_clients {
--    bufnr = vim.api.nvim_get_current_buf(),
--    name = 'pyright',
--  }
--  for _, client in ipairs(clients) do
--    client.config.settings = vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
--    client.notify('workspace/didChangeConfiguration', { settings = nil })
--  end
--end
--require('lspconfig').pyright.setup({
--	on_attach = function(client, bufnr)
--		print('pyright attached')
--	end,
--    cmd = { 'pyright-langserver', '--stdio' },
--    filetypes = { 'python' },
--    root_dir = function(fname)
--      return util.root_pattern(unpack(root_files))(fname)
--    end,
--    single_file_support = true,
--    settings = {
--          python = {
--            analysis = {
--              autoSearchPaths = true,
--              useLibraryCodeForTypes = true,
--              diagnosticMode = 'openFilesOnly',
--            },
--          },
--        },
--    commands = {
--        PyrightOrganizeImports = {
--          organize_imports,
--          description = 'Organize Imports',
--        },
--        PyrightSetPythonPath = {
--          set_python_path,
--          description = 'Reconfigure pyright with the provided python path',
--          nargs = 1,
--          complete = 'file',
--        },
--    }
--})
lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

vim.api.nvim_create_augroup("AutoFormat", {})

vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        pattern = "*.py",
        group = "AutoFormat",
        callback = function()
            vim.cmd("silent !black --quiet %")            
            vim.cmd("edit")
        end,
    }
)
