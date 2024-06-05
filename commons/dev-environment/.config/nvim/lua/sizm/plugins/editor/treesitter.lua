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
    local autotag = require('nvim-ts-autotag')

    configs.setup({
      ensure_installed = {
        'lua',
        'vim',
        'vimdoc',
        'query',
        'html',
        'embedded_template', -- erb (eruby)
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
        'xml',
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

      -- to fix eruby autoclose
      --  https://github.com/windwp/nvim-ts-autotag/issues/64
      --  https://github.com/windwp/nvim-ts-autotag/issues/149
      -- Even though support for eruby was added in:
      --  https://github.com/windwp/nvim-ts-autotag/pull/104
      autotag.setup({}),
    })
  end,
}
