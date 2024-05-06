return {
  -- colorschemes for editor
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,

  config = function()
    require('catppuccin').setup({
      transparent_background = true, -- disables setting the background color.
    })

    -- setup must be called before loading
    vim.cmd.colorscheme('catppuccin')
  end,
}
