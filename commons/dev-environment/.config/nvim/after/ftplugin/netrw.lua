-- fix for: https://github.com/christoomey/vim-tmux-navigator/issues/189

-- fix in https://github.com/christoomey/vim-tmux-navigator/commit/5b3c701686fb4e6629c100ed32e827edf8dad01e
-- does not work as expected, I think beacuse of lazy loading of plugins on keymaps
vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<CR>', { silent = true, buffer = true })

-- remap: C-l to C-r for refresh
vim.keymap.set(
  'n',
  '<C-r>',
  '<cmd>e .<CR>',
  { desc = 'Refresh Netrw', silent = true, buffer = true }
)
