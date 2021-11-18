local comment = require('Comment')
local map = require("utils").map
local silent = { silent=true }

comment.setup()
map("n", "<leader>/", ":lua require'Comment'.toggle()<CR>", silent)
map("v", "<leader>/", ":lua require'Comment'.toggle()<CR>", silent)
