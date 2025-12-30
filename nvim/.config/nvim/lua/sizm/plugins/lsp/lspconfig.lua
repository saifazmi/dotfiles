return {
  -- pre-defined LSP configurations
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
  },

  config = function()
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

    -- Change the Diagnostic symbols in the sign column (gutter)
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = ' ',
          [vim.diagnostic.severity.WARN] = ' ',
          [vim.diagnostic.severity.INFO] = ' ',
          [vim.diagnostic.severity.HINT] = ' ',
        },
      },
    })

    -- configure lua server (with special settings for vim)
    vim.lsp.config('lua_ls', {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand('$VIMRUNTIME/lua')] = true,
              [vim.fn.stdpath('config') .. '/lua'] = true,
            },
          },
        },
      },
    })
    vim.lsp.enable('lua_ls')

    -- configure bash server
    vim.lsp.config('bashls', {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.enable('bashls')

    -- configure markdown server
    vim.lsp.config('marksman', {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.enable('marksman')

    -- configure terraform server
    vim.lsp.config('terraformls', {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.enable('terraformls')

    -- configure html server
    vim.lsp.config('html', {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.enable('html')

    -- configure emmet language server
    vim.lsp.config('emmet_ls', {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.enable('emmet_ls')

    -- configure css server
    vim.lsp.config('cssls', {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.enable('cssls')

    -- configure tailwindcss server
    vim.lsp.config('tailwindcss', {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.enable('tailwindcss')

    -- configure eslint server for linting
    vim.lsp.config('eslint', {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.enable('eslint')

    -- configure javsacript & typescript server (ts_ls)
    vim.lsp.config('ts_ls', {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.enable('ts_ls')

    -- configure python server (basedpyright)
    vim.lsp.config('basedpyright', {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.enable('basedpyright')

    -- configure ruff server for linting and formatting
    -- vim.lsp.config('ruff', {
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- })
    -- vim.lsp.enable('ruff')

    -- configure ruby server (solargraph)
    vim.lsp.config('solargraph', {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.enable('solargraph')

    -- configure go server
    vim.lsp.config('gopls', {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          analyses = {
            unusedparams = true,
          },
        },
      },
    })
    vim.lsp.enable('gopls')

    -- configure c & cpp server
    vim.lsp.config('clangd', {
      capabilities = capabilities,
      on_attach = on_attach,
      init_options = {
        clangdFileStatus = true,
        completeUnimported = true,
        usePlaceholders = true,
      },
    })
    vim.lsp.enable('clangd')
  end,
}
