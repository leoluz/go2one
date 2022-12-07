require("plugins")
require("settings")
require("mappings")
require("autocmd")

local gotest = require "go2one.gotest"

gotest.setup {
  results_handler = "telescope",
}
