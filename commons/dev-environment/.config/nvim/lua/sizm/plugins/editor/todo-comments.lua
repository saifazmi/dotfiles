return {
  -- highlight and search for todo comments
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },

  cmd = { 'TodoTrouble', 'TodoTelescope' },
  -- https://github.com/LazyVim/LazyVim/discussions/1583
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' }, -- mimics LazyFile

  keys = {
    { '<leader>ft', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<CR>', desc = 'Find TODOs in cwd' },
    { '<leader>fT', '<cmd>TodoTelescope<CR>', desc = 'Find all comments in cwd' },
    { '<leader>td', '<cmd>TodoTrouble toggle filter.buf=0<CR>', desc = 'Toggle TODOs for buffer' },
  },

  opts = {},
}
