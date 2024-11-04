local indent_symbol = '│'
local exclude_filetypes = {
  'help',
  'lazy',
  'mason',
  'oil',
  'oil_preview',
  'dashboard',
  'undotree',
  'Trouble',
  'trouble',
}

return {
  {
    -- add indent lines to code block
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    main = 'ibl',

    opts = {
      indent = {
        char = indent_symbol,
        tab_char = indent_symbol,
      },
      whitespace = {
        remove_blankline_trail = true,
      },
      scope = { enabled = false },
      exclude = {
        filetypes = exclude_filetypes,
      },
    },
  },

  {
    -- for fancy animated indent line highlight
    'echasnovski/mini.indentscope',
    version = '*', -- stable
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },

    opts = {
      symbol = indent_symbol,
      options = {
        border = 'top',
        try_as_border = true,
      },
    },

    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = exclude_filetypes,
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
