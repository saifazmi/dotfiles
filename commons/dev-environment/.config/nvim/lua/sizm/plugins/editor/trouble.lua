return {
  -- list of diagnostics, LSP ref, qfix list, etc.
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = {
    'Trouble',
    'TroubleToggle',
    'TroubleClose',
    'TroubleRefresh',
  },
  keys = {
    { '<leader>t', '<cmd>TroubleToggle<CR>', desc = 'Toggle Trouble widnow' },
  },

  opts = {
    use_diagnostic_signs = true,
  },
}
