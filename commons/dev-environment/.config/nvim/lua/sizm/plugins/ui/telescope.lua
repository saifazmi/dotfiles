return {
  -- picker with fuzzy finding capabilities
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope-ui-select.nvim',
  },

  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local config = require('telescope.config')

    -- clone default telescope configuration
    local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

    -- add argument to search hidden files
    table.insert(vimgrep_arguments, '--hidden')
    -- don't want to search in the `.git` directory
    table.insert(vimgrep_arguments, '--glob')
    table.insert(vimgrep_arguments, '!**/.git/*')

    telescope.setup({
      defaults = {
        -- `hidden = true` is not supported in text grep commands.
        vimgrep_arguments = vimgrep_arguments,
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-h>'] = actions.select_horizontal,
          },
        },
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown({}),
        },
      },
    })

    telescope.load_extension('fzf')
    telescope.load_extension('ui-select')

    local builtin = require('telescope.builtin')

    local keymap = vim.keymap -- for conciceness

    -- file searches
    keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files in cwd' })
    keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Find recent files' })
    keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Find Git files' })

    -- string searches (grep)
    keymap.set('n', '<leader>fs', builtin.live_grep, { desc = 'Find string in cwd' })
    keymap.set('n', '<leader>fS', builtin.grep_string, { desc = 'Find string under cursor in cwd' })

    -- vim searches (buffers, help_tags, qflist, etc.)
    keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find open buffers' })
    keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find NeoVim help_tags' })
  end,
}
