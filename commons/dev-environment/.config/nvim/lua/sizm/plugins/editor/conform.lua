return {
  -- code formatter
  'stevearc/conform.nvim',
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' },

  config = function()
    local conform = require('conform')

    conform.setup({
      formatters_by_ft = {
        lua = { 'stylua' },
        bash = { 'shfmt' },
        markdown = { 'prettierd' },

        html = { 'prettierd' },
        eruby = { 'erb_format' },
        css = { 'prettierd' },
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        typescriptreact = { 'prettierd' },

        json = { 'prettierd' },
        jsonc = { 'prettierd' },
        yaml = { 'prettierd' },
        terraform = { 'terraform_fmt' },

        python = { 'ruff_fix', 'ruff_format' },
        ruby = { 'rubocop' },
        go = { 'gofumpt', 'goimports-reviser', 'golines' },
        c = { 'clang_format' },
      },

      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ 'n', 'v' }, '<leader>mp', function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = 'Format file or range (in visual mode)' })
  end,
}
