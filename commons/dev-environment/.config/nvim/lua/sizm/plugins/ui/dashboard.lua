return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },

  opts = function()
    local logo = [[
       ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
       ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
       ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
       ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
       ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
       ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
    ]]

    logo = string.rep('\n', 8) .. logo .. '\n\n'

    local opts = {
      theme = 'doom',
      config = {
        header = vim.split(logo, '\n'),
        center = {
          {
            action = 'ene | startinsert',
            desc = ' New file',
            icon = ' ',
            key = 'n'
          },
          {
            action = 'Telescope find_files',
            desc = ' Find file',
            icon = ' ',
            key = 'f'
          },
          {
            action = 'Telescope oldfiles',
            desc = ' Recent files',
            icon = ' ',
            key = 'r'
          },
          {
            action = 'Telescope live_grep',
            desc = ' Find text',
            icon = ' ',
            key = 'g'
          },
          { action = 'qa',
            desc = ' Quit',
            icon = ' ',
            key = 'q'
          },
        },
        footer = function()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
        end
      }
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(' ', 43 - #button.desc)
      button.key_format = '  %s'
    end

    return opts
  end
}
