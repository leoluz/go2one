local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
local silent = { silent=true }

-- map leader key to space.
vim.g.mapleader = " "

-- maps for window management
map("n", "<leader>j", "<C-W>j")
map("n", "<leader>k", "<C-W>k")
map("n", "<leader>h", "<C-W>h")
map("n", "<leader>l", "<C-W>l")
map("n", "<leader>m", "<C-W>_")
map("n", "<leader>=", "<C-W>=")
map("n", "<leader>-", "5<C-W>-")
map("n", "<leader>+", "5<C-W>+")
map("n", "<leader>.", "10<C-W>>")
map("n", "<leader>,", "10<C-W><")

-- close quickfix window
map("n", "<leader>x", ":ccl<CR>")

-- format JSON
map("n", "<silent><leader>gj", ":%!python -m json.tool<CR>")

-- nvim-dap maps
map("n", "<F7>", ":lua require'dap'.toggle_breakpoint()<CR>", silent)
map("n", "<F8>", ":lua require'dap'.continue()<CR>", silent)
map("n", "<F9>", ":lua require'dap'.step_over()<CR>", silent)
map("n", "<F10>", ":lua require'dap'.step_into()<CR>", silent)
map("n", "<F11>", ":lua require'dap'.step_out()<CR>", silent)
map("n", "<leader>i", ":lua require'dapui'.eval()<CR>", silent)

-- misc maps
map("i", "<C-s>", "<ESC>:w<CR>")
map("i", "<C-@>", "<C-x><C-o>")
map("i", "<C-l>", "<ESC>A")
map("n", "<F4>", ":setlocal spell! spelllang=en_us<CR>")
map("n", "Y", "y$")
map("n", "j", "gj")
map("n", "k", "gk")
map("n", "gb", "`.")
map("n", "<C-s>", ":w<CR>")
map("n", "<C-l>", ":bnext<CR>")
map("n", "<C-h>", ":bprevious<CR>")
map("n", "<BS>", ":BD<CR>")
map("n", "<C-_>", ":q!<CR>")
map("n", "<leader>v", ":e $MYVIMRC<CR>", silent)
map("n", "<C-x>", ":split term://bash<CR>", silent)
map("n", "<leader>a", "ggVG$", silent)
map("i", "<C-a>", "<ESC>ggvG$")
map("v", "<silent><C-s>", ":sort<CR>", silent)

-- Terminal mappings
map("t", "<C-n>", "<C-\\><C-n>")

--"" NerdCommenter maps
--nmap <silent><leader>/ <plug>NERDCommenterToggle
--vmap <leader>/ <plug>NERDCommenterToggle
