local g = vim.g
local map = require("utils").map
local silent = { silent=true }

g.dashboard_default_executive = "telescope"
map("n", "<leader>fr", ":DashboardFindHistory<CR>", silent)
map("n", "<leader>fl", ":SessionLoad<CR>", silent)
map("n", "<leader>fn", ":DashboardNewFile<CR>", silent)
map("n", "<leader>fm", ":DashboardJumpMarks<CR>", silent)

g.dashboard_custom_header = {
"  ██████╗  ██████╗ ██████╗  ██████╗ ███╗   ██╗███████╗",
" ██╔════╝ ██╔═══██╗╚════██╗██╔═══██╗████╗  ██║██╔════╝",
" ██║  ███╗██║   ██║ █████╔╝██║   ██║██╔██╗ ██║█████╗  ",
" ██║   ██║██║   ██║██╔═══╝ ██║   ██║██║╚██╗██║██╔══╝  ",
" ╚██████╔╝╚██████╔╝███████╗╚██████╔╝██║ ╚████║███████╗",
"  ╚═════╝  ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝",
}

g.dashboard_custom_section = {
  last_session = {
    description = {" Load saved session                    SPC f l"},
    command = "SessionLoad",
  },
  find_history = {
    description = {" Recently opened files                 SPC f r"},
    command = "DashboardFindHistory",
  },
  find_file = {
    description = {" Find file                             SPC f f"},
    command = "DashboardFindFile",
  },
  new_file = {
    description = {" New file                              SPC f n"},
    command = "DashboardNewFile",
  },
  find_word = {
    description = {" Find word (grep)                      SPC f g"},
    command = "DashboardFindWord",
  },
  find_bookmarks = {
    description = {" Find marks                            SPC f m"},
    command = "DashboardJumpMarks",
  },
  file_browser = {
    description = {" File browser                          SPC f b"},
    command = "lua require('telescope.builtin').file_browser()",
  },
}
