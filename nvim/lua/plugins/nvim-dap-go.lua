local dapgo = require('dap-go')
local map = require("utils").map
local silent = { silent=true }

dapgo.setup()
map("n", "<leader>y", dapgo.debug_test, silent)
