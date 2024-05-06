-- fix for: https://github.com/christoomey/vim-tmux-navigator/issues/189
vim.keymap.set('n', '<c-l>', '<cmd>TmuxNavigateRight<CR>', { silent = true, buffer = true })

vim.keymap.set('n', '<c-r>', '<cmd>e .<CR>', { silent = true, buffer = true })
