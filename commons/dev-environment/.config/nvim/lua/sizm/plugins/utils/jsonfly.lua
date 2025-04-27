return {
  -- search json, xml, yaml files
  'Myzel394/jsonfly.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },

  keys = {
    {
      '<leader>fj',
      '<cmd>Telescope jsonfly<CR>',
      desc = 'Search json(fly)',
      ft = { 'json', 'jsonc', 'xml', 'yaml' },
      mode = 'n',
    },
  },

  config = function()
    local telescope = require('telescope')
    telescope.setup({
      extensions = {
        jsonfly = {
          subkeys_display = 'waterfall',
          mirror = true,
          layout_strategy = 'vertical',
          layout_config = {
            mirror = true,
            preview_height = 0.65,
            prompt_position = 'top',
          },
          key_exact_length = true,
        },
      },
    })

    telescope.load_extension('jsonfly')
  end,
}
