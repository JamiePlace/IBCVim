local lsp = require("lsp-zero")

lsp.preset("recommended")
lsp.ensure_installed({
    'pyright',
    'pylsp',
    'lua_ls'
})
-- Fix Undefined global 'vim'
-- Fix Undefined global 'vim'
lsp.nvim_workspace()
local cmp = require('cmp')
local luasnip = require('luasnip')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_snippet = {expand = function(args)
    luasnip.lsp_expand(args.body)
end}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<TAB>'] = cmp.mapping.confirm({ select = true }),
  ['<CR>'] = cmp.mapping.close(),
  ['<C-u>'] = cmp.mapping.scroll_docs(-4),
  ['<C-d>'] = cmp.mapping.scroll_docs(4),
})
local cmp_sources = {
  {name = 'path'},
  {name = 'nvim_lsp', keyword_length = 1},
  {name = 'buffer', keyword_length = 3},
  {name = 'luasnip', keyword_length = 2},
}
local cmp_window = {documentation = cmp.config.window.bordered()}
local cmp_formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
        local menu_icon = {
            nvim_lsp = 'λ',
            luasnip = '⋗',
            buffer = 'Ω',
            path = '🖫',
        }

        item.menu = menu_icon[entry.source.name]
        return item
    end,
}
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  formatting = cmp_formatting,
  sources = cmp_sources,
  window = cmp_window,
  snippet = cmp_snippet
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

  vim.keymap.set("n", "gd", function() 
      vim.cmd('belowright split')
      vim.lsp.buf.definition() 
  end, opts)
  vim.keymap.set("n", "<leader>gd", function() 
      vim.lsp.buf.definition() 
  end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

vim.diagnostic.config({
    virtual_text = true
})
require('lspconfig').pylsp.setup {
    on_attach = on_attach,
    settings = {
        -- configure plugins in pylsp
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = {'W391'},
                    maxLineLength = 79
                },
                pyflakes = {enabled = false},
                pylint = {enabled = false},
                flake8 = { enabled = false},
                pylint = {enable = true}
            },
        },
    },
}
require'lspconfig'.pyright.setup{
    on_attach = on_attach,
    settings = {
        root_dir = {
            GIT_ROOT_DIR        
        }
    }
}
lsp.setup()
