local telescope = require("telescope")
local actions = require "telescope.actions"
local map = require("utils").map
local builtin = require('telescope.builtin')

local silent = { silent=true }

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<esc>"] = require('telescope.actions').close,
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
telescope.load_extension("fzf")
telescope.load_extension('lsp_handlers')
telescope.load_extension('gh')
telescope.load_extension('repo')

map("n", "<leader>ff", builtin.find_files, silent)
map("n", "<leader>fh", builtin.help_tags, silent)
map("n", "<leader>fg", builtin.live_grep, silent)
map("n", "<leader>fk", builtin.keymaps, silent)
map("n", "<leader>f;", telescope.extensions.repo.list, silent)
map("n", "<leader>b", builtin.buffers, silent)
-- shows all diff for current buffer
map("n", "<leader>gd", builtin.git_bcommits, silent)
map("n", "<leader>gl", builtin.git_commits, silent)
