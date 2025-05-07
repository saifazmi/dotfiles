local user = vim.env.USER or 'User'
user = user:sub(1, 1):upper() .. user:sub(2)

return {
  {
    -- Github Copilot pure lua implementation
    'zbirenbaum/copilot.lua',
    build = ':Copilot auth',

    cmd = 'Copilot',

    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },

  {
    -- Github Copilot completion source for nvim-cmp
    'zbirenbaum/copilot-cmp',
    dependencies = 'copilot.lua',

    event = 'InsertEnter',
    config = function()
      require('copilot_cmp').setup()
    end,
  },

  {
    -- Github Copilot chat
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },

    build = 'make tiktoken', -- Only on MacOS or Linux

    cmd = { 'CopilotChat', 'CopilotChatOpen' },
    keys = {
      { '<leader>cc', '<cmd>CopilotChatOpen<CR>', mode = 'n', desc = 'Open Copilot Chat window' },
    },

    opts = {
      question_header = '  ' .. user .. ' ',
      answer_header = '  Copilot ',
    },
  },
}
