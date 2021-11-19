local map = require("utils").map
local silent = { silent=true }

vim.g.nvim_tree_icons = {
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
  lsp= {
    hint= "",
    info= "",
    warning= "",
    error= "",
  }
}

local tree = require("nvim-tree")
tree.setup{
  update_focused_file = {
    enable      = true,
    update_cwd  = false,
  },
}

map("n", "<leader>q", ":NvimTreeToggle<CR>", silent)
