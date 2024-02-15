-- fix for: https://github.com/christoomey/vim-tmux-navigator/issues/189
vim.keymap.set('n', '<c-l>', ':TmuxNavigateRight<CR>', {
  silent = true, buffer = true
})

