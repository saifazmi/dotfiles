return {
  -- view and edit files as vim buffer
  'stevearc/oil.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  keys = {
    { '-', '<cmd>Oil<CR>', desc = 'Open parent directory' },
  },

  opts = {
    view_options = { show_hidden = true },
  },

  config = true, -- runs require('oil').setup()
}
