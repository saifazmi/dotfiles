return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp'
  },
  config = function()
    local lspconfig = require('lspconfig')
    local cmp_nvim_lsp = require('cmp_nvim_lsp')

    local keymap = vim.keymap -- for conciseness
    local opts = { noremap = true, silent = true }

    local on_attach = function(client, bufnr)
      opts.buffer = bufnr

      -- set keybinds
      opts.desc = 'Show LSP references'
      keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts)

      opts.desc = 'Go to declaration'
      keymap.set('n', 'gd', vim.lsp.buf.declaration, opts)

      opts.desc = 'Show LSP definitions'
      keymap.set('n', 'gD', '<cmd>Telescope lsp_definitions<CR>', opts)

      opts.desc = 'Show LSP implementations'
      keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)

      opts.desc = 'Show LSP type definitions'
      keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts)

      opts.desc = 'See available code actions'
      keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

      opts.desc = 'Smart rename'
      keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

      opts.desc = 'Show buffer diagnostics'
      keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)

      opts.desc = 'Show line diagnostics'
      keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)

      opts.desc = 'Go to previous diagnostic'
      keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)

      opts.desc = 'Go to next diagnostic'
      keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

      opts.desc = 'Show documentation for what is under cursor'
      keymap.set('n', 'K', vim.lsp.buf.hover, opts)

      opts.desc = 'Restart LSP'
      keymap.set('n', '<leader>rs', '<cmd>LspRestart<CR>', opts)
    end

    -- used to enable autocompletion
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- CHange the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    -- configure lua server (with special settings for vim)
    lspconfig['lua_ls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          -- make the language server recognise 'vim' global
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand('$VIMRUNTIME/lua')] = true,
              [vim.fn.stdpath('config') .. '/lua'] = true
            }
          }
        }
      }
    })

    -- configure html server
    lspconfig['html'].setup({
      capabilities = capabilities,
      on_attach = on_attach
    })

    -- configure emmet language server
    lspconfig['emmet_ls'].setup({
      capabilities = capabilities,
      on_attach = on_attach
    })

    -- configure css server
    lspconfig['cssls'].setup({
      capabilities = capabilities,
      on_attach = on_attach
    })

    -- configure tailwindcss server
    lspconfig['tailwindcss'].setup({
      capabilities = capabilities,
      on_attach = on_attach
    })

    -- configure ruby server (solargraph)
    lspconfig['solargraph'].setup({
      capabilities = capabilities,
      on_attach = on_attach
    })
  end
}
