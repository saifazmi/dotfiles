return {
  'rmagatti/auto-session',
  lazy = false,

  keys = {
    -- Will use Telescope if installed or a vim.ui.select picker otherwise
    { '<leader>wr', '<cmd>AutoSession search<CR>', desc = 'Session search' },
    { '<leader>ws', '<cmd>AutoSession save<CR>', desc = 'Save session' },
    { '<leader>wa', '<cmd>AutoSession toggle<CR>', desc = 'Toggle autosave' },
  },

  config = function()
    local auto_session = require('auto-session')

    auto_session.setup({
      suppressed_dirs = {
        '/',
        '~/',
        '~/Desktop',
        '~/Documents',
        '~/Downloads',
        '~/workspace',
      },
    })
  end,
}
