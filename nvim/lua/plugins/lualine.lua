return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local lualine = require("lualine")
    lualine.setup {
      sections = {
        lualine_a = {
          {
            'lsp_status',
            icon = '', -- f013
            symbols = {
              -- Standard unicode symbols to cycle through for LSP progress:
              spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
              -- Standard unicode symbol for when LSP is done:
              done = '✓',
              -- Delimiter inserted between LSP names:
              separator = ' ',
            },
            -- List of LSP names to ignore (e.g., `null-ls`):
            ignore_lsp = {},
          }
        },
        lualine_c = {
          {
            'filename',
            path = 1,
            file_status = true,
          },
        }
      }
    }
  end,
}
