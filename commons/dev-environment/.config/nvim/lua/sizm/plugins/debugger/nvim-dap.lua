return {
  -- debugger
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    { 'theHamsta/nvim-dap-virtual-text', opts = {} },
  },
  lazy = true,
  event = 'VeryLazy',

  -- stylua: ignore start
  keys = {
    { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint' },

    { '<leader>dc', function() require('dap').continue() end, desc = 'Run/Continue' },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { '<leader>dp', function() require('dap').pause() end, desc = 'Pause' },
    { '<leader>dt', function() require('dap').terminate() end, desc = 'Terminate' },

    { '<leader>do', function() require('dap').step_over() end, desc = 'Step Over' },
    { '<leader>di', function() require('dap').step_into() end, desc = 'Step Into' },
    { '<leader>dO', function() require('dap').step_out() end, desc = 'Step Out' },

    { '<leader>dj', function() require('dap').down() end, desc = 'Down' },
    { '<leader>dk', function() require('dap').up() end, desc = 'Up' },
  },
  -- stylua: ignore end

  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    -- use nvim-dap events to open and close the dap-ui windows automatically
    dapui.setup()
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- define adapter and configuration per language

    -- JS/TS/React
    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'js-debug-adapter',
        args = {
          '${port}',
        },
      },
    }

    for _, language in ipairs({ 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' }) do
      dap.configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
      }
    end
  end,
}
