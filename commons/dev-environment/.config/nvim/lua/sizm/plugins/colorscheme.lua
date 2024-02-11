return {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
        -- load colorscheme on launch
        vim.cmd([[colorscheme catppuccin]])
    end
}
