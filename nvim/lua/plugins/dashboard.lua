return {
  "glepnir/dashboard-nvim",
  event = 'VimEnter',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'cljoly/telescope-repo.nvim',
  },
  enabled = false,
  config = function()
    require('dashboard').setup {
      theme = 'hyper',
      config = {
        header = {
          "  ██████╗  ██████╗ ██████╗  ██████╗ ███╗   ██╗███████╗",
          " ██╔════╝ ██╔═══██╗╚════██╗██╔═══██╗████╗  ██║██╔════╝",
          " ██║  ███╗██║   ██║ █████╔╝██║   ██║██╔██╗ ██║█████╗  ",
          " ██║   ██║██║   ██║██╔═══╝ ██║   ██║██║╚██╗██║██╔══╝  ",
          " ╚██████╔╝╚██████╔╝███████╗╚██████╔╝██║ ╚████║███████╗",
          "  ╚═════╝  ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝",
        },
        week_header = {
          enable = false,
        },
        disable_move = false,
        shortcut = {
          {
            desc = '󰊳 Update',
            group = '@property',
            action = 'Lazy update',
            key = 'u'
          },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            desc = ' Apps',
            group = 'DiagnosticHint',
            action = 'Telescope app',
            key = 'a',
          },
          {
            desc = ' Repos',
            group = 'Number',
            action = function() require('telescope').extensions.repo.list() end,
            key = 'r',
          },
        },
      },
    }
  end,
}
