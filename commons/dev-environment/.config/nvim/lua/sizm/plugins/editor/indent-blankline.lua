return {
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    main = 'ibl',

    opts = {
      indent = {
        char = '│',
        tab_char = '│'
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          'help',
          'lazy',
          'mason',
          'oil',
          'dashboard'
        }
      }
    }
  },

}
