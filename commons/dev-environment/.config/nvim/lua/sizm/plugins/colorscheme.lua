return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
      -- load colorscheme on launch
      vim.cmd([[colorscheme catppuccin]])
    end
  },

  {
    'folke/tokyonight.nvim',
    lazy = true,
    opts = { style = 'night' },
  }
}

