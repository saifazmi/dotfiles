return {
  'stevearc/oil.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },

  keys = {
    { '-', '<cmd>Oil<CR>', { desc = 'Open parent directory' } }
  },
  config = function()
    require("oil").setup()
    -- vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end
}
