-- Native Neovim v0.12+ built-in packages
-- These replace external plugins using :packadd for built-in optional packages

-- undotree: built-in undo history visualiser (replaces mbbill/undotree)
vim.cmd.packadd('nvim.undotree')
vim.keymap.set('n', '<leader>u', '<cmd>Undotree<CR>', { desc = 'Toggle undotree' })
