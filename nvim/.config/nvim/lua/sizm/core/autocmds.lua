-- Terraform filetype configuration and fix for tf -> terraform
vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])

-- Check for file changes on relevant events
vim.api.nvim_create_autocmd(
  { 'FocusGained', 'CursorHold', 'CursorHoldI', 'BufEnter', 'BufLeave' },
  {
    pattern = '*',
    callback = function()
      if vim.fn.mode() ~= 'c' then
        vim.cmd('checktime')
      end
    end,
  }
)

-- Notify when file is reloaded
vim.api.nvim_create_autocmd({ 'FileChangedShellPost' }, {
  pattern = '*',
  callback = function()
    vim.notify('File changed on disk, reloaded!', vim.log.levels.WARN)
  end,
})
