return {
  -- fuzzy finder
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-h>'] = actions.select_horizontal,
          },
        },
      },
    })

    telescope.load_extension('fzf')

    local builtin = require('telescope.builtin')

    local keymap = vim.keymap -- for conciceness

    -- file searches
    keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files in cwd' })
    keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Find recent files' })

    -- string searches (grep)
    keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Find string in cwd' })
    keymap.set('n', '<leader>fc', builtin.grep_string, { desc = 'Find string under cursor in cwd' })

    -- vim searches (buffers, help_tags, qflist, etc.)
    keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find open buffers' })
    keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find NeoVim help_tags' })
  end,
}
