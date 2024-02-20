return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'RRethy/nvim-treesitter-endwise',
    'windwp/nvim-ts-autotag'
  },

  config = function ()
    local configs = require('nvim-treesitter.configs')

    configs.setup({
      ensure_installed = {
        'c', 'lua', 'vim', 'vimdoc', 'query',
        'html', 'css', 'javascript', 'typescript',
        'bash', 'python', 'ruby', 'go', 'rust',
        'markdown', 'yaml', 'json', 'jsonc', 'csv'
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      endwise = { enable = true },  -- dep: nvim-treesitter-endwise
      autotag = { enable = true }   -- dep: nvim-ts-autotag
    })
  end
}

