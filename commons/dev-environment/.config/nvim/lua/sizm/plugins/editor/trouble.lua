return {
  -- list of diagnostics, LSP ref, qfix list, etc.
  'folke/trouble.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'echasnovski/mini.icons',
  },
  cmd = 'Trouble',
  keys = {
    {
      '<leader>t',
      '<cmd>Trouble diagnostics toggle<CR>',
      desc = 'Toggle Trouble (diagnostics) window',
    },
  },

  opts = {},
}
