local utils = require "utils"

local map = utils.map
local silent = { silent = true }
local expr = { expr = true }

-- map leader key to space.
vim.g.mapleader = " "

-- maps for window management
map("n", "<leader>j", "<C-W>j")
map("n", "<leader>k", "<C-W>k")
map("n", "<leader>h", "<C-W>h")
map("n", "<leader>l", "<C-W>l")
map("n", "<leader>m", "<C-W>_")
map("n", "<leader>=", "<C-W>=")
map("n", "<leader>.", "10<C-W>>")
map("n", "<leader>,", "10<C-W><")

-- close quickfix window
map("n", "<leader>x", ":ccl<CR>")

-- format JSON
map("n", "<leader>gj", ":%!jq .<CR>", silent)

-- misc maps
map("i", "<C-s>", "<ESC>:w<CR>")
map("i", "<C-@>", "<C-x><C-o>")
map("i", "<C-l>", "<ESC>A")
map("n", "<F4>", ":setlocal spell! spelllang=en_us<CR>")
map("n", "Y", "y$")
map("n", "j", "(v:count == 0 ? 'gj' : 'j')", expr)
map("n", "k", "(v:count == 0 ? 'gk' : 'k')", expr)
map("n", "gb", "`.")
map("n", "<C-s>", ":w<CR>")
map("n", "<BS>", ":bdelete<CR>")
map("n", "_", ":bdelete!<CR>")
map("n", "<leader>-", ":q!<CR>")
map("n", "<leader>v", ":e $MYVIMRC<CR>", silent)
map("n", "<C-x>", ":split term://bash<CR>", silent)
map("n", "<leader>a", "ggVG$", silent)
map("i", "<C-a>", "<ESC>ggvG$")
map("v", "<silent><C-s>", ":sort<CR>", silent)
map("n", "<leader>s", ":lua require'utils'.reload('go2one')<CR>")

-- Terminal mappings
map("t", "<C-n>", "<C-\\><C-n>")

map("n", "<leader>t",
    ":lua require'go2one.gotest'.test_nearest({layout_strategy = 'vertical', layout_config = {preview_cutoff = 1}})<CR>"
    , silent)
