return {
  -- consistent integrated navigation between nvim and tmux
  'christoomey/vim-tmux-navigator',
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
  },

  keys = {
    { '<C-h>', '<cmd><C-U>TmuxNavigateLeft<cr>', desc = 'Navigate Left' },
    { '<C-j>', '<cmd><C-U>TmuxNavigateDown<cr>', desc = 'Navigate Down' },
    { '<C-k>', '<cmd><C-U>TmuxNavigateUp<cr>', desc = 'Navigate Up' },
    { '<C-l>', '<cmd><C-U>TmuxNavigateRight<cr>', desc = 'Navigate Right' },
    { '<C-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>', desc = 'Navigate to last pane/split' },
  },

  config = function()
    -- see: https://github.com/christoomey/vim-tmux-navigator?tab=readme-ov-file#netrw
    vim.g.tmux_navigator_disable_netrw_workaround = 1
  end,
}
