local opt = vim.opt

-- [[ FORMATTING
    opt.tabstop = 4             -- width of the tab character
    opt.softtabstop = 4         -- how many columns the tab key inserts
    opt.shiftwidth = 4          -- width of 1 indentation level
    opt.expandtab = true        -- expand tabs into spaces
    opt.smartindent = true      -- smart C-like autoindenting
-- ]]

-- [[ INTERFACE
    opt.guicursor = ''          -- set cursor to block in insert mode
    opt.colorcolumn = '80,120'  -- display a column marker
    opt.number = true           -- show line number
    opt.relativenumber = true   -- show relative line numbers
    opt.showmatch = true        -- when inserting brackets, highlight match
    opt.wrap = false            -- disable line wrap
    opt.splitbelow = true       -- horizontal split editor to bottom
    opt.splitright = true       -- vertical split editor to right
    opt.listchars = {           -- set invisible characters
        tab = '▸ ',
        eol = '¬',
        trail = '·',
        extends = '»',
        precedes = '«'
    }
-- ]]

-- [[ SEARCH BEHAVIOUR
    opt.ignorecase = true       -- ignore case in search patterns
    opt.smartcase = true        -- no ignore case when pattern has uppercase
-- ]]

-- [[ APPEARANCE
    opt.termguicolors = true    -- to make colour scheme work properly
-- ]]

-- [[ CLIPBOARD
    -- use system clipboard
    opt.clipboard:append('unnamedplus')
-- ]]

