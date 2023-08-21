return {
  {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'gbrlsnchs/telescope-lsp-handlers.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
      'nvim-telescope/telescope-github.nvim',
      'cljoly/telescope-repo.nvim',
    },
    config = function()
      local telescope = require("telescope")
      local actions = require "telescope.actions"
      local map = require("utils").map
      local builtin = require('telescope.builtin')
      local silent = { silent = true }
      telescope.setup {
          defaults = {
              layout_strategy = 'flex',
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
      -- telescope.load_extension("fzf")
      telescope.load_extension('lsp_handlers')
      telescope.load_extension('gh')
      telescope.load_extension('repo')

      local function git_branches()
        builtin.git_branches({ show_remote_tracking_branches = false })
      end

      map("n", "<leader>ff", builtin.find_files, silent)
      map("n", "<leader>fh", builtin.help_tags, silent)
      map("n", "<leader>fg", builtin.live_grep, silent)
      map("n", "<leader>fk", builtin.keymaps, silent)
      map("n", "<leader>f;", telescope.extensions.repo.list, silent)
      map("n", "<leader>b", builtin.buffers, silent)
      -- shows all diff for current buffer
      map("n", "<leader>gd", builtin.git_bcommits, silent)
      map("n", "<leader>gl", builtin.git_commits, silent)
      map("n", "<leader>gb", git_branches, silent)
      map("n", "<leader>gs", builtin.git_status, silent)
    end,
  },
  { 'nvim-lua/plenary.nvim' },
  { "gbrlsnchs/telescope-lsp-handlers.nvim" },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { "nvim-telescope/telescope-github.nvim" },
  { "cljoly/telescope-repo.nvim" },
}
