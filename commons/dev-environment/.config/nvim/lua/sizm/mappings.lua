local keymap = vim.keymap -- for conciseness

-- remap <leader> to Space Bar key
vim.g.mapleader = ' '     

-- file explorer
keymap.set('n', '<leader>fe', vim.cmd.Ex)

-- window management
keymap.set('n', '<leader>sv', '<C-w>v') -- split window vertically
keymap.set('n', '<leader>sh', '<C-w>s') -- split window horizontally
keymap.set('n', '<leader>se', '<C-w>=') -- make split windows equal width & height
keymap.set('n', '<leader>sx', ':close<CR>') -- close current split window
