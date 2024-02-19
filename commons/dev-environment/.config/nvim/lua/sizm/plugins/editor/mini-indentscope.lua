return {
  -- for fancy animated indent line
  'echasnovski/mini.indentscope',
  version = '*',  -- stable
  event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },

  opts = {
    symbol = '│',
    options = { try_as_border = true }
  },
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'help',
        'lazy',
        'mason',
        'oil',
        'dashboard'
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end
    })
  end
}