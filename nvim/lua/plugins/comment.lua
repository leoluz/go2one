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
        line = 'gcc',
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
    map("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", silent)
    map("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", silent)
  end
}
