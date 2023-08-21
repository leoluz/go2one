return {
  "windwp/nvim-autopairs",
  config = function()
    local autopairs = require('nvim-autopairs')
    autopairs.setup({
      disable_filetype = { "TelescopePrompt", "vim" },
    })
  end
}
