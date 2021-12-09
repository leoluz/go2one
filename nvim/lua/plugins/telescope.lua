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

map("n", "<C-p>", ":lua require'telescope.builtin'.find_files()<CR>", silent)
map("n", "<leader>ff", ":lua require'telescope.builtin'.find_files()<CR>", silent)
map("n", "<leader>fh", ":lua require'telescope.builtin'.help_tags()<CR>", silent)
map("n", "<leader>fg", ":lua require('telescope.builtin').live_grep()<CR>", silent)
map("n", "<leader>fk", ":lua require('telescope.builtin').keymaps()<CR>", silent)
map("n", "<leader>fd", ":lua require('telescope.builtin').lsp_workspace_diagnostics()<CR>", silent)
map("n", "<leader>fs", ":lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>", silent)
map("n", "<leader>fe", ":lua require('telescope.builtin').file_browser()<CR>", silent)
map("n", "<leader>f;", ":lua require('telescope').extensions.repo.list()<CR>", silent)
map("n", "<leader>b", ":lua require('telescope.builtin').buffers()<CR>", silent)

-- shows all diff for current buffer
map("n", "<leader>gd", ":lua require('telescope.builtin').git_bcommits()<CR>", silent)
map("n", "<leader>gl", ":lua require('telescope.builtin').git_commits()<CR>", silent)
