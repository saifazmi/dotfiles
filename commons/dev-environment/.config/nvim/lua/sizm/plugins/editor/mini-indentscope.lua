return {
  -- for fancy animated indent line highlight
  'echasnovski/mini.indentscope',
  version = '*', -- stable
  event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },

  opts = {
    symbol = '│',
    options = {
      border = 'top',
      try_as_border = true,
    },
  },

  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
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
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
