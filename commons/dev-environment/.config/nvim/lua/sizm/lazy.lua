local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { import = 'sizm.plugins.utils' },
  { import = 'sizm.plugins.ui' },
  { import = 'sizm.plugins.file_management' },
  { import = 'sizm.plugins.editor' },
  { import = 'sizm.plugins.git' },
  { import = 'sizm.plugins.lsp' },
  { import = 'sizm.plugins.ai' },
}, {
  install = { colorscheme = { 'catppuccin' } },
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
})
