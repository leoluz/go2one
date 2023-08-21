local g = vim.g
g.onedark_style = "dark"
require("onedark").setup()
local colors = require('onedark.colors')

vim.cmd("highlight TelescopeBorder guifg="..colors.grey)
vim.cmd("highlight TelescopePromptBorder guifg="..colors.grey)
vim.cmd("highlight TelescopeResultsBorder guifg="..colors.grey)
vim.cmd("highlight TelescopePreviewBorder guifg="..colors.grey)
