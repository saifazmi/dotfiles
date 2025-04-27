-- stylua: ignore start

local opt = vim.opt           -- for conciseness

-- [[ FORMATTING
  opt.tabstop = 4             -- width of the tab character
  opt.softtabstop = 4         -- how many columns the tab key inserts
  opt.shiftwidth = 4          -- width of 1 indentation level
  opt.expandtab = true        -- expand tabs into spaces
  opt.smartindent = true      -- smart C-like autoindenting
-- ]]

-- [[ INTERFACE
  opt.guicursor = ''          -- set cursor to block in insert mode
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
  opt.autoread = true         -- auto reload files changed outside of nvim
  opt.foldenable = true       -- enable folding
  opt.foldlevel = 99          -- open all folds by default
  opt.foldmethod = 'expr'     -- fold based on expression
  opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- ]]

-- [[ SEARCH BEHAVIOUR
  opt.ignorecase = true       -- ignore case in search patterns
  opt.smartcase = true        -- no ignore case when pattern has uppercase
-- ]]

-- [[ APPEARANCE
  opt.termguicolors = true    -- to make colour scheme work properly
-- ]]

-- [[ CLIPBOARD
  opt.clipboard:append('unnamedplus') -- use system clipboard
-- ]]

-- stylua: ignore end
