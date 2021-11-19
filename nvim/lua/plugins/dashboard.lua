local g = vim.g
local map = require("utils").map
local silent = { silent=true }

g.dashboard_default_executive = "telescope"
g.dashboard_custom_header = {
"  ██████╗  ██████╗ ██████╗  ██████╗ ███╗   ██╗███████╗",
" ██╔════╝ ██╔═══██╗╚════██╗██╔═══██╗████╗  ██║██╔════╝",
" ██║  ███╗██║   ██║ █████╔╝██║   ██║██╔██╗ ██║█████╗  ",
" ██║   ██║██║   ██║██╔═══╝ ██║   ██║██║╚██╗██║██╔══╝  ",
" ╚██████╔╝╚██████╔╝███████╗╚██████╔╝██║ ╚████║███████╗",
"  ╚═════╝  ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝",
}

--'last_session'] = ' '
--'find_history'] = ' '
--'find_file'] = ' '
--'new_file'] = ' '
--'find_word'] = ' '
--'book_marks'] = ' '

map("n", "<leader>fr", ":DashboardFindHistory<CR>", silent)
map("n", "<leader>fl", ":SessionLoad<CR>", silent)
map("n", "<leader>fn", ":DashboardNewFile<CR>", silent)
map("n", "<leader>fm", ":DashboardJumpMarks<CR>", silent)

g.dashboard_custom_section = {
  last_session = {
    description = {" Load saved session                    <space>fl"},
    command = "SessionLoad",
  },
  find_history = {
    description = {" Recently opened files                 <space>fr"},
    command = "DashboardFindHistory",
  },
  find_file = {
    description = {" Find file                             <space>ff"},
    command = "DashboardFindFile",
  },
  new_file = {
    description = {" New file                              <space>fn"},
    command = "DashboardNewFile",
  },
  find_word = {
    description = {" Find word (grep)                      <space>fg"},
    command = "DashboardFindWord",
  },
  find_bookmarks = {
    description = {" Find marks                            <space>fm"},
    command = "DashboardJumpMarks",
  },
  file_browser = {
    description = {" File browser                          <space>fb"},
    command = "lua require('telescope.builtin').file_browser()",
  },
}
