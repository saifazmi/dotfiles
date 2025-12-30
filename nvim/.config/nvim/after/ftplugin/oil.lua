-- refresh current Oil buffer
vim.keymap.set(
  'n',
  '<C-r>',
  '<cmd>Oil .<CR>',
  { desc = 'Refresh Oil', silent = true, buffer = true }
)
