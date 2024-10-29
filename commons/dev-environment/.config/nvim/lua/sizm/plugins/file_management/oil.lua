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
    default_file_explorer = false,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    watch_for_changes = true,
    keymaps = {
      -- fix: for vim-tmux-navigator conflict similar to netrw
      ['<C-h>'] = false, -- disable to fix TmuxNavigateLeft conflict
      ['<C-l>'] = false, -- disable to fix TmuxNavigateRight conflict
    },
    view_options = { show_hidden = true },
  },

  config = true, -- runs require('oil').setup()
}
