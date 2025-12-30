return {
  -- list of diagnostics, LSP ref, qfix list, etc.
  'folke/trouble.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    -- 'echasnovski/mini.icons',
  },

  cmd = 'Trouble',

  keys = {
    {
      '<leader>tt',
      '<cmd>Trouble diagnostics toggle filter.buf=0<CR>',
      desc = 'Toggle Diagnostics for buffer',
    },
    {
      '<leader>tT',
      '<cmd>Trouble diagnostics toggle<CR>',
      desc = 'Toggle Diagnostics for cwd',
    },
  },

  opts = {},
}
