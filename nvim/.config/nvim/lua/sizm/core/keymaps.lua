local keymap = vim.keymap -- for conciseness

vim.g.mapleader = ' ' -- remap <leader> to Space Bar key

keymap.set('i', 'jj', '<Esc>', { noremap = true, desc = '<Esc>' }) -- remap jj to Esc in insert mode

keymap.set('n', '<leader>e', vim.cmd.Ex, { desc = 'Open Netrw' }) -- file explorer

-- buffer management
keymap.set('n', '<leader>bd', ':bd<CR>', { desc = 'Delete this buffer' })
keymap.set('n', '<leader>bn', ':bn<CR>', { desc = 'Switch to next buffer' })
keymap.set('n', '<leader>bp', ':bp<CR>', { desc = 'Switch to previous buffer' })

-- window management
keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
keymap.set('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal width and height' })
keymap.set('n', '<leader>sx', ':close<CR>', { desc = 'Close this window split' })

keymap.set('n', '<leader>k', '4<C-w>+', { desc = 'Increase split height by 1 line' })
keymap.set('n', '<leader>j', '4<C-w>-', { desc = 'Decrease split height by 1 line' })
keymap.set('n', '<leader>l', '8<C-w>>', { desc = 'Increase split width by 1 column' })
keymap.set('n', '<leader>h', '8<C-w><', { desc = 'Increase split width by 1 column' })
