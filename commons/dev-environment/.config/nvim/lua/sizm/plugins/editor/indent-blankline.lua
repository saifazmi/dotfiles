return {
  -- add indent lines to code block
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
  main = 'ibl',

  opts = {
    indent = {
      char = '│',
      tab_char = '│',
    },
    whitespace = {
      remove_blankline_trail = true,
    },
    scope = { enabled = false },
    exclude = {
      filetypes = {
        'help',
        'lazy',
        'mason',
        'oil',
        'oil_preview',
        'dashboard',
        'undotree',
        'Trouble',
        'trouble',
      },
    },
  },
}
