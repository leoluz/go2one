vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  dev = {
    path = "~/git",
    fallback = true,
  },
  concurrency = 3,
  -- git = {
  --   cooldown = 1,
  --   throttle = {
  --     enabled = true, -- not enabled by default
  --     -- max 2 ops every 5 seconds
  --     rate = 3,
  --     duration = 5 * 1000, -- in ms
  --   },
  -- },
}
require("lazy").setup("plugins", opts)
