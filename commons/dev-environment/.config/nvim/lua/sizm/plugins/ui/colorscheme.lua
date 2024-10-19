return {
  -- colorschemes for editor
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,

  config = function()
    require('catppuccin').setup({
      transparent_background = true, -- disables setting the background color.
      dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = 'light',
        percentage = 0.30, -- percentage of the shade to apply to the inactive window
      },
    })

    -- setup must be called before loading
    vim.cmd.colorscheme('catppuccin')
  end,
}
