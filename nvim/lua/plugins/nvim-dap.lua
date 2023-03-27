require("dap")
local map = require("utils").map
local silent = { silent = true }

vim.fn.sign_define('DapStopped', { text = '▸', texthl = '', linehl = 'debugPC', numhl = '' })
vim.fn.sign_define('DapBreakpoint', { text = '🔵', texthl = '', linehl = '', numhl = '' })

map("n", "<F7>", ":lua require'dap'.toggle_breakpoint()<CR>", silent)
map("n", "<F8>", ":lua require'dap'.continue()<CR>", silent)
map("n", "<F9>", ":lua require'dap'.step_over()<CR>", silent)
map("n", "<F10>", ":lua require'dap'.step_into()<CR>", silent)
map("n", "<F11>", ":lua require'dap'.step_out()<CR>", silent)
map("n", "<leader>i", ":lua require'dapui'.eval()<CR>", silent)
map("n", "<leader>du", ":lua require'dapui'.toggle()<CR>", silent)
map("n", "<leader>dc", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map("n", "<leader>di", ":lua require'dap'.step_into()<CR>")
map("n", "<leader>do", ":lua require'dap'.step_over()<CR>")
map("n", "<leader>dd", ":lua require'dap'.continue()<CR>")
map("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>")


-- TODO explore those functions
--<leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
--<leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
--<leader>i :lua require'dap.ui.widgets'.hover()<CR>
--<leader>dl :lua require'dap'.run_last()<CR>
