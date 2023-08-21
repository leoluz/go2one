return {
  "numToStr/Comment.nvim",
  config = function()
    local comment = require('Comment')
    local map = require("utils").map
    local silent = { silent = true }

    comment.setup({
      ---LHS of toggle mappings in NORMAL + VISUAL mode
      ---@type table
      toggler = {
        ---Line-comment toggle keymap
        line = 'g/',
        ---Block-comment toggle keymap
        block = 'gbc',
      },

      ---LHS of operator-pending mappings in NORMAL + VISUAL mode
      ---@type table
      opleader = {
        ---Line-comment keymap
        line = 'gc',
        ---Block-comment keymap
        block = 'gb',
      },
    })
    -- map("n", "<leader>/", ":lua require('Comment.api').call('toggle_linewise_op')<CR>", silent)
    -- map("v", "<leader>/", ":lua require('Comment.api').call('toggle_blockwise_op')<CR>", silent)
  end
}
