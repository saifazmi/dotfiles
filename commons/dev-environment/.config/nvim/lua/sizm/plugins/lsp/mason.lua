return {
  -- install and manage language tools (like: LSP, linters, formatters, etc)
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },

  config = function()
    local mason = require('mason')
    local mason_lspconfig = require('mason-lspconfig')
    local mason_tool_installer = require('mason-tool-installer')

    mason.setup({
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        'lua_ls',
        'html',
        'emmet_ls',
        'cssls',
        'tailwindcss',
        'pyright', -- python
        'solargraph', -- ruby
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installtion = true, -- not the same as ensure_installed
    })

    mason_tool_installer.setup({
      ensure_installed = {
        'stylua', -- lua formatter
        'prettier', -- web dev frontend stack formatter
        'eslint_d', -- javascript & typescript linter
        'isort', -- python imports sorter (formatter)
        'black', -- python formatter
        'pylint', -- python linter
        'rubocop', -- ruby linter and formatter
      },
    })
  end,
}
