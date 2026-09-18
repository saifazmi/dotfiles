return {
  'sphamba/smear-cursor.nvim',
  event = 'VeryLazy',
  config = function()
    require('smear_cursor').setup({
      -- Configuration here, or leave empty to use defaults
    })
  end,
}
