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
          'mason'
        }
      }
    }
  },

  {
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
          'mason'
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end
      })
    end
  }
}
