local keymap = vim.keymap -- for conciseness

vim.g.mapleader = ' ' -- remap <leader> to Space Bar key

keymap.set('n', '<leader>e', vim.cmd.Ex) -- file explorer
keymap.set('i', 'jj', '<Esc>', { noremap = true, desc = '<Esc>' }) -- remap jj to Esc in insert mode

-- buffer management
keymap.set('n', '<leader>bd', ':bd<CR>') -- delete buffer

-- window management
keymap.set('n', '<leader>sv', '<C-w>v') -- split window vertically
keymap.set('n', '<leader>sh', '<C-w>s') -- split window horizontally
keymap.set('n', '<leader>se', '<C-w>=') -- make splits equal width & height
keymap.set('n', '<leader>sx', ':close<CR>') -- close current split window

keymap.set('n', '<leader>k', '4<C-w>+') -- increase split height by 1 line
keymap.set('n', '<leader>j', '4<C-w>-') -- decrease split height by 1 line
keymap.set('n', '<leader>l', '8<C-w>>') -- increase split width by 1 column
keymap.set('n', '<leader>h', '8<C-w><') -- decrease split width by 1 column
