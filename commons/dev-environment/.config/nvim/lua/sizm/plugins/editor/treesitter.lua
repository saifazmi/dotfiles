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

    -- stylua: ignore start
    configs.setup({
      ensure_installed = {
        -- vim
        'lua', 'luadoc', 'vim', 'vimdoc', 'query',
        -- git
        'git_config', 'gitcommit', 'git_rebase', 'gitignore', 'gitattributes', 'diff',

        -- programming languages --
        -- web dev
        'html', 'css', 'scss',
        -- javascript
        'javascript', 'typescript', 'tsx',
        -- sys dev
        'bash', 'c', 'cpp', 'cmake', 'make', 'powershell',
        -- python
        'python',
        -- go
        'go', 'gomod', 'gowork', 'gosum',
        -- ruby, rails
        'ruby', 'embedded_template', -- erb (eruby)

        -- data formats --
        'csv','xml',
        'sql',
        -- json
        'json', 'jsonc', 'json5',

        -- infra configs --
        'dockerfile',
        -- terraform
        'terraform', 'hcl',

        -- *nix configs --
        'ssh_config', 'tmux',

        -- markup languages --
        'latex',
        -- markdown
        'markdown', 'markdown_inline',

        -- config formats --
        'yaml', 'toml'
      },
      -- stylua: ignore end 

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
