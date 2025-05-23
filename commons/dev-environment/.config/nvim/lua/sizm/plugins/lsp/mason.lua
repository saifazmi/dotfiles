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
      -- for local mason development
      -- registries = {
      --   'file:~/workspace/oss/mason-registry',
      -- },
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
        'bashls',
        'marksman', -- markdown
        'terraformls',
        'html',
        'emmet_ls',
        'cssls',
        'tailwindcss',
        'eslint', -- javascript and typescript linter via lsp
        'ts_ls', -- javascript and typescript
        'basedpyright', -- python
        'solargraph', -- ruby
        'gopls', -- go
        'clangd', -- c, cpp
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installtion = true, -- not the same as ensure_installed
    })

    mason_tool_installer.setup({
      ensure_installed = {
        'stylua', -- lua formatter
        'shellcheck', -- bash linter
        'shfmt', -- bash formatter
        'markdownlint', -- markdown linter
        'tflint', -- terraform linter
        'prettierd', -- web dev frontend stack + markdown formatter
        'ruff', -- python linter and formatter
        'rubocop', -- ruby linter and formatter
        'erb-lint', -- erb template linter
        'erb-formatter', -- erb template formatter
        'gofumpt', -- go formatter
        'goimports-reviser', -- go imports formatter
        'golines', -- go long lines formatter
        -- 'cppcheck', -- c, cpp linter
        'clang-format', -- c, cpp formatter
      },
    })
  end,
}
