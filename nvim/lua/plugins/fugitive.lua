return {
  "tpope/vim-fugitive",
  config = function()
    local map = require("utils").map
    local silent = { silent = true }

    map("n", "<leader>gg", ":Git<CR>", silent)
    map("n", "<leader>gc", ":Git commit -s<CR>", silent)
    map("n", "<leader>gp", ":Git push<CR>", silent)
  end,
}
