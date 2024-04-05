return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local lualine = require("lualine")
    lualine.setup {
      sections = {
        lualine_c = {
          {
            'filename',
            path = 1,
            file_status = true,
          }
        }
      }
    }
  end,
}
