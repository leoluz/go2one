local api = vim.api
local bo = vim.bo
local utils = require("utils")
local cmp = require("cmp")

-- will format file before saving based on attached lsp capabilities
api.nvim_create_augroup("lsp", { clear = true })
api.nvim_create_autocmd("BufWritePre", {
  group = "lsp",
  pattern = "*",
  callback = utils.auto_format_lsp,
})

-- yaml configurations
local bufferOpts = function()
  bo.tabstop = 2
  bo.softtabstop = 2
  bo.shiftwidth = 2
  bo.expandtab = true
  vim.wo.cursorcolumn = true
end
api.nvim_create_augroup("yaml", { clear = true })
api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  group = "yaml",
  pattern = {"*.yaml", "*.yml"},
  callback = bufferOpts,
})
api.nvim_create_autocmd({"BufLeave", "BufWinLeave"}, {
  group = "yaml",
  pattern = {"*.yaml", "*.yml"},
  callback = function() vim.wo.cursorcolumn = false end,
})

-- lua configurations
local luaOpts = function()
  cmp.setup.buffer {
    sources = {
      { name = 'buffer' },
      { name = 'nvim_lua' },
      { name = 'ultisnips' },
      { name = 'nvim_lsp' },
    }
  }
  return bufferOpts()
end
api.nvim_create_augroup("lua", { clear = true })
api.nvim_create_autocmd("FileType", {
  group = "lua",
  pattern = "lua",
  callback = luaOpts,
})

-- golang configurations
local goOpts = function()
  bo.tabstop = 4
  bo.softtabstop = 4
  bo.shiftwidth = 4
  bo.expandtab = false
end
api.nvim_create_augroup("golang", { clear = true })
api.nvim_create_autocmd("FileType", {
  group = "golang",
  pattern = "go",
  callback = goOpts,
})

-- -- term configurations
-- vim.cmd[[
-- augroup term
--   autocmd!
--   au TermOpen * setlocal listchars= nonumber norelativenumber signcolumn=no
--   au TermOpen * startinsert
--   au BufEnter,BufWinEnter,WinEnter term://* startinsert
--   au BufLeave term://* stopinsert
-- augroup END
-- ]]
--
