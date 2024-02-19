return {
  'stevearc/oil.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },

  keys = {
    { '-', '<cmd>Oil<CR>', { desc = 'Open parent directory' } }
  },
  config = true -- runs require('oil').setup()
}
