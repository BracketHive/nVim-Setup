local lsp = require('lsp-zero')

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  lsp.default_keymaps({buffer =bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'tsserver', 'lua_ls', 'html', 'volar', 'somesass_ls', 'intelephense', },
  handlers = {
    tsserver = function()
      require('lspconfig').tsserver.setup({})
    end,
    lua_ls = function()
      require('lspconfig').lua_ls.setup({})
    end,
    html = function()
      require('lspconfig').html.setup({})
    end,
    volar = function()
      require('lspconfig').volar.setup({})
    end,
    somesass_ls = function()
      require('lspconfig').somesass_ls.setup({})
    end,
    intelephense = function()
      require('lspconfig').intelephense.setup({})
    end,
  },
})

local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    ['<Down>'] = cmp.mapping.select_next_item({behavior = 'select'}),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<C-Space>'] = cmp.mapping.abort(),
  },
})
