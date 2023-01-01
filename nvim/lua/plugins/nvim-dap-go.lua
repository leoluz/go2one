local dapgo = require('dap-go')
local map = require("utils").map
local silent = { silent=true }

require('dap-go').setup {
  delve = {
    initialize_timeout_sec = 30,
  },
}
map("n", "<leader>y", dapgo.debug_test, silent)
