return {
  -- code highlight
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  dependencies = {
    'RRethy/nvim-treesitter-endwise', -- auto close 'end' for ruby, lua, etc.
    'windwp/nvim-ts-autotag', -- auto close html tags
  },

  config = function()
    -- stylua: ignore start
    require('nvim-treesitter').install({
      -- vim
      'lua', 'luadoc', 'vim', 'vimdoc', 'query',
      -- git
      'git_config', 'gitcommit', 'git_rebase', 'gitignore', 'gitattributes', 'diff',

      -- programming languages --
      -- web dev
      'html', 'css', 'scss',
      -- javascript
      'javascript', 'typescript', 'tsx', 'jsdoc',
      -- sys dev
      'bash', 'c', 'cpp', 'cmake', 'make', 'powershell',
      -- python
      'python',
      -- go
      'go', 'gomod', 'gowork', 'gosum',
      -- ruby, rails
      'ruby', 'embedded_template', -- erb (eruby)

      -- data formats --
      'csv', 'xml',
      'sql',
      -- json
      'json', 'json5',

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
      'yaml', 'toml',
    })
    -- stylua: ignore end

    -- Enable treesitter highlighting per filetype.
    -- pcall silently skips filetypes with no installed parser.
    -- Indentation is handled natively by vim.treesitter in v0.12+.
    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })

    -- to fix eruby autoclose
    --  https://github.com/windwp/nvim-ts-autotag/issues/64
    --  https://github.com/windwp/nvim-ts-autotag/issues/149
    -- Even though support for eruby was added in:
    --  https://github.com/windwp/nvim-ts-autotag/pull/104
    require('nvim-ts-autotag').setup({})
  end,
}
