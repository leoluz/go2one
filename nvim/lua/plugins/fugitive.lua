return {
  {
    "tpope/vim-fugitive",
    config = function()
      local map = require("utils").map
      local silent = { silent = true }

      map("n", "<leader>gg", ":Git<CR>", silent)
      map("n", "<leader>gc", ":Git commit -s<CR>", silent)
      map("n", "<leader>gp", ":Git push<CR>", silent)
    end,
  },
  {
    -- :GBrowse from fugitive.vim to open GitHub URLs
    "tpope/vim-rhubarb",
    config = function()
      local map = require("utils").map
      local silent = { silent = true }
      map("n", "<leader>gh", ":GBrowse<CR>", silent)
    end,
  }
}
