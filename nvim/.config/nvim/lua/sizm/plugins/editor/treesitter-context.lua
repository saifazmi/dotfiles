return {
  'nvim-treesitter/nvim-treesitter-context',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  event = 'VeryLazy',
  config = function()
    require('treesitter-context').setup({
      enable = true,
      max_lines = 5, -- Maximum number of context lines to show
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 1, -- Maximum number of lines to show for a single context
      trim_scope = 'outer', -- Which context lines to discard if max_lines is exceeded
      mode = 'cursor', -- Line used to calculate context. 'cursor' or 'topline'
      separator = nil, -- Separator between context and content
      zindex = 20, -- The Z-index of the context window
    })
  end,
}
