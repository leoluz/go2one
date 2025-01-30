return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'gbrlsnchs/telescope-lsp-handlers.nvim',
      'nvim-telescope/telescope-github.nvim',
      'cljoly/telescope-repo.nvim',
      -- 'nvim-telescope/telescope-fzf-native.nvim',
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
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
          advanced_git_search = {
            -- Fugitive or diffview
            diff_plugin = "fugitive",
            -- Customize git in previewer
            -- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
            git_flags = {},
            -- Customize git diff in previewer
            -- e.g. flags such as { "--raw" }
            git_diff_flags = {},
            -- Show builtin git pickers when executing "show_custom_functions" or :AdvancedGitSearch
            show_builtin_git_pickers = false,
          },
        },
      }
      telescope.load_extension("fzf")
      telescope.load_extension('lsp_handlers')
      telescope.load_extension('gh')
      telescope.load_extension('repo')
      telescope.load_extension("advanced_git_search")
      telescope.load_extension('projects')

      local function git_branches()
        builtin.git_branches({ show_remote_tracking_branches = false })
      end

      map("n", "<leader>ff", builtin.find_files, silent)
      map("n", "<leader>fh", builtin.help_tags, silent)
      map("n", "<leader>fg", builtin.live_grep, silent)
      map("n", "<leader>fk", builtin.keymaps, silent)
      map("n", "<leader>fd", builtin.diagnostics, silent)
      map("n", "<leader>f;", telescope.extensions.repo.list, silent)
      map("n", "<leader>b", builtin.buffers, silent)
      -- shows all diff for current buffer
      map("n", "<leader>gd", builtin.git_bcommits, silent)
      map("n", "<leader>gl", builtin.git_commits, silent)
      map("n", "<leader>gb", git_branches, silent)
      map("n", "<leader>gs", builtin.git_status, silent)
      -- list of all previous commits. Grep commit content
      map("n", "<leader>ghh", telescope.extensions.advanced_git_search.search_log_content, silent)
      -- list of git commits that changed the current file. Grep commit content
      map("n", "<leader>ghf", telescope.extensions.advanced_git_search.search_log_content_file, silent)
      -- list of git commits that changed the current file. Grep commit message
      map("n", "<leader>ghc", telescope.extensions.advanced_git_search.diff_commit_file, silent)
    end,
  },
  { 'nvim-lua/plenary.nvim',                 dependencies = { "nvim-telescope/telescope.nvim" } },
  { "gbrlsnchs/telescope-lsp-handlers.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
  { "nvim-telescope/telescope-github.nvim",  dependencies = { "nvim-telescope/telescope.nvim" } },
  { "cljoly/telescope-repo.nvim",            dependencies = { "nvim-telescope/telescope.nvim" } },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  {
    "aaronhallaert/advanced-git-search.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tpope/vim-fugitive",
    },
  },
}
