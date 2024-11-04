return {
  -- search and open terraform docs from telescope
  'ANGkeith/telescope-terraform-doc.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },

  keys = {
    {
      '<leader>ftd',
      '<cmd>Telescope terraform_doc<CR>',
      desc = 'Search terraform doc',
      ft = { 'terraform' },
      mode = 'n',
    },
    {
      '<leader>ftm',
      '<cmd>Telescope terraform_doc modules<CR>',
      desc = 'Search terraform modules',
      ft = { 'terraform' },
      mode = 'n',
    },
    {
      '<leader>fta',
      '<cmd>Telescope terraform_doc full_name=hashicorp/aws<CR>',
      desc = 'Search terraform AWS provider',
      ft = { 'terraform' },
      mode = 'n',
    },
    {
      '<leader>ftg',
      '<cmd>Telescope terraform_doc full_name=hashicorp/google<CR>',
      desc = 'Search terraform GCP provider',
      ft = { 'terraform' },
      mode = 'n',
    },
  },

  config = function()
    local telescope = require('telescope')
    telescope.load_extension('terraform_doc')
  end,
}
