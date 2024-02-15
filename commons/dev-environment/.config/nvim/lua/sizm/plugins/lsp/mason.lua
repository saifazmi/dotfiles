return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
  },

  config = function()
    local mason = require('mason')
    local mason_lspconfig = require('mason-lspconfig')

    mason.setup({
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗'
        }
      }
    })

    mason_lspconfig.setup({
      ensure_installed = {
        'lua_ls',
        'html',
        'emmet_ls',
        'cssls',
        'tailwindcss',
        'solargraph'
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installtion = true -- not the same as ensure_installed
    })
  end
}

