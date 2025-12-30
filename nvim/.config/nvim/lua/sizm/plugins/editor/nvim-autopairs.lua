return {
  -- auto close brackets
  'windwp/nvim-autopairs',
  event = 'InsertEnter',

  config = function()
    local npairs = require('nvim-autopairs')

    npairs.setup({
      enable_check_bracket_line = false,
      check_ts = true, -- enable treesitter
      ts_config = {
        -- don't add pairs in lua string treesitter nodes
        lua = { 'string' },
        -- don't add pairs in javascript template_string treesitter nodes
        javascript = { 'template_string' },
        -- don't check treesitter in java
        java = false,
      },
    })

    -- import nvim-autopairs completion functionality
    local npairs_cmp = require('nvim-autopairs.completion.cmp')

    -- import nvim-cmp plugin (completions plugin)
    local cmp = require('cmp')

    -- make autopairs and completion work together
    cmp.event:on('confirm_done', npairs_cmp.on_confirm_done())
  end,
}
