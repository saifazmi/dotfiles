return {
  -- autocomplete support
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-buffer', -- source for text in buffer
    'hrsh7th/cmp-path', -- source for file system paths
    'L3MON4D3/LuaSnip', -- snippet engine
    'saadparwaiz1/cmp_luasnip', -- source for LuaSnip
    'rafamadriz/friendly-snippets', -- useful snippets for diff languages
    'onsails/lspkind.nvim', -- vs-code like icons in autocomplete menu
    'zbirenbaum/copilot-cmp', -- source for copilot
  },

  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')

    -- loads vscode style snippets from installed plugins
    -- (eg: friendly-snippets)
    require('luasnip.loaders.from_vscode').lazy_load()

    cmp.setup({
      completion = {
        completeopt = 'menu,menuone,preview,noselect',
      },

      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ['<C-k>'] = cmp.mapping.select_prev_item(), -- prev suggestion
        ['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
        ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- preview back
        ['<C-f>'] = cmp.mapping.scroll_docs(4), -- preview forward
        ['<C-s>'] = cmp.mapping.complete(), -- show suggestions
        ['<C-c>'] = cmp.mapping.abort(), -- close window
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
      }),

      -- sources for autocompletion
      -- order of the sources determines their recommendation order
      sources = cmp.config.sources({
        { name = 'copilot' }, -- copilot
        { name = 'nvim_lsp' }, -- lsp
        { name = 'luasnip' }, -- snippets
        { name = 'buffer' }, -- text within current buffer
        { name = 'path' }, -- file system paths
      }),

      -- configure lspkind for vs-code like icons in completion menu
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          preset = 'codicons',
          ellipsis_char = '...',
          symbol_map = {
            Copilot = '',
          },
        }),
      },
    })
  end,
}
