local telescope = require("telescope")
local map = require("utils").map
local silent = { silent=true }

telescope.setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    lsp_handlers = {
      code_action = {
        telescope = require('telescope.themes').get_dropdown({}),
      },
    },
  },
}

map("n", "<C-p>", ":lua require'telescope.builtin'.find_files()<CR>", silent)
