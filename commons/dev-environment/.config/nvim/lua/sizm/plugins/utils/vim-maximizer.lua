return {
  -- maximise current split
  'szw/vim-maximizer',
  cmd = {
    'MaximizerToggle',
  },
  keys = {
    { '<leader>z', '<cmd>MaximizerToggle<CR>', desc = 'Maximise this split' },
  },
}
