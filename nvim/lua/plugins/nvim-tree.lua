local map = require("utils").map
local silent = { silent=true }

-- need to require "nvim-tree" after setting the global configurations
-- for it to work properly
local tree = require("nvim-tree")
tree.setup{
  update_cwd = true,
  update_focused_file = {
    enable      = true,
    update_cwd  = false,
  },
  renderer = {
    icons = {
      glyphs = {
        default =        "",
        symlink =        "",
        git = {
           unstaged =    "⚠",
           staged=       "✓",
           unmerged=     "",
           renamed=      "➜",
           untracked=    "★",
           deleted=      "",
        },
        folder= {
          arrow_open=   "",
          arrow_closed= "",
          default=      "",
          open=         "",
          empty=        "",
          empty_open=   "",
          symlink=      "",
          symlink_open= "",
        },
        -- lsp= {
        --   hint= "",
        --   info= "",
        --   warning= "",
        --   error= "",
        -- }
      }
    }
  }
}

map("n", "<leader>q", ":NvimTreeToggle<CR>", silent)
