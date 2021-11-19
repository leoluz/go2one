local telescope = require("telescope")
local actions = require "telescope.actions"
local map = require("utils").map
local silent = { silent=true }

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
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
map("n", "<leader>h", ":lua require'telescope.builtin'.help_tags()<CR>", silent)
map("n", "<leader>f", ":lua require('telescope.builtin').live_grep()<CR>", silent)
