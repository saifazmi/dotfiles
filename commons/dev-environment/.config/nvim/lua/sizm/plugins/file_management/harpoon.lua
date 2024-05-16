return {
  -- pin and toggle between frequent files
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },

  config = function()
    local harpoon = require('harpoon')

    harpoon:setup() -- required for autocmds setup

    local keymap = vim.keymap -- for conciceness

    -- keybindings
    keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = 'Harpoon this file' })

    keymap.set('n', '<leader>hs', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Show Harpoon board' })

    keymap.set('n', '<leader>1', function()
      harpoon:list():select(1)
    end, { desc = 'Harpooned file #1' })
    keymap.set('n', '<leader>2', function()
      harpoon:list():select(2)
    end, { desc = 'Harpooned file #2' })
    keymap.set('n', '<leader>3', function()
      harpoon:list():select(3)
    end, { desc = 'Harpooned file #3' })
    keymap.set('n', '<leader>4', function()
      harpoon:list():select(4)
    end, { desc = 'Harpooned file #4' })

    -- Toggle previous & next buffers stored within Harpoon list
    keymap.set('n', '<leader>hp', function()
      harpoon:list():prev()
    end, { desc = 'Previous harpooned file' })
    keymap.set('n', '<leader>hn', function()
      harpoon:list():next()
    end, { desc = 'Next harpooned file' })
  end,
}
