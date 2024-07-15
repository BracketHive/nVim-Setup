return {
  { "rose-pine/neovim", name = "rose-pine" },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim"},
    config = function ()
      local harpoon = require("harpoon")

      -- REQUIRED
      harpoon:setup()
      -- REQUIRED

      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
      vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
      vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
    end
  },

  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function ()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
      vim.keymap.set('n', 'C-p', builtin.git_files, {})
      vim.keymap.set('n', '<leader>ps', function()
	      builtin.grep_string({ search = vim.fn.input("Grep > ") });
      end)
    end
  },

  {
    'tpope/vim-fugitive',
    config = function ()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
    end
  },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    config = function ()
      -- LSP
      local lsp = require('lsp-zero')

      lsp.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        lsp.default_keymaps({buffer =bufnr})
      end)

      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = { 'tsserver', 'lua_ls', 'html', 'volar', 'tailwindcss', 'somesass_ls', 'intelephense', 'cssls', 'jsonls', 'emmet_ls' },
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
          tailwindcss = function()
            require('lspconfig').tailwindcss.setup({})
          end,
          somesass_ls = function()
            require('lspconfig').somesass_ls.setup({})
          end,
          intelephense = function()
            require('lspconfig').intelephense.setup({})
          end,
          emmet_ls = function ()
            require('lspconfig').emmet_ls.setup({})
          end,
          cssls = function()
            require('lspconfig').cssls.setup({})
          end,
          jsonls = function()
            require('lspconfig').jsonls.setup({})
          end,
        },
      })

      local cmp = require('cmp')

      cmp.setup({
      sources = {
        {name = 'nvim_lsp'},
      },
      mapping = {
        ['<S-Tab>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
        ['<Tab>'] = cmp.mapping.select_next_item({behavior = 'select'}),
        ['<Enter>'] = cmp.mapping.confirm({select = true}),
        ['<C-Space>'] = cmp.mapping.abort(),
      },
    })
    end
  },
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  {'L3MON4D3/LuaSnip'},

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the listed parsers MUST always be installed)
        ensure_installed = { "javascript", "typescript", "vue", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        highlight = {
          enable = true,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }
    end
  },
}
