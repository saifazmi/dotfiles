return {
  -- code highlight
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'RRethy/nvim-treesitter-endwise', -- auto close 'end' for ruby, lua, etc.
    'windwp/nvim-ts-autotag', -- auto close html tags
  },

  config = function()
    local configs = require('nvim-treesitter.configs')

    configs.setup({
      ensure_installed = {
        'lua',
        'vim',
        'vimdoc',
        'query',
        'html',
        'css',
        'javascript',
        'typescript',
        'bash',
        'c',
        'cpp',
        'python',
        'ruby',
        'go',
        'rust',
        'markdown',
        'yaml',
        'toml',
        'json',
        'jsonc',
        'csv',
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      endwise = { enable = true }, -- dep: nvim-treesitter-endwise
      autotag = { enable = true }, -- dep: nvim-ts-autotag
    })
  end,
}
