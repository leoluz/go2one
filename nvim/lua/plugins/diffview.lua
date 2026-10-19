return {
  "sindrets/diffview.nvim",
  config = function()
    local map = require("utils").map
    -- will open diff view with all commits from current branch
    -- not in master. Three dots notation will ignore new commits
    -- in master so it can be rebased with no problem.
    map("n", "<leader>do", ":DiffviewOpen master...HEAD<CR>")
    map("n", "<leader>dc", ":DiffviewClose<CR>")

    local actions = require("diffview.config").actions
    require("diffview").setup({
      enhanced_diff_hl = true,
      hooks = {
        -- never fold unchanged lines in diff windows
        diff_buf_win_enter = function(_, winid)
          vim.wo[winid].foldenable = false
        end,
      },
      view = {
        default = {
          layout = "diff2_vertical",
        },
        merge_tool = {
          layout = "diff3_mixed",
        },
        file_history = {
          layout = "diff2_vertical",
        },
      },
      keymaps = {
        view = {
          ["<leader>q"] = actions.toggle_files,
          --jump to next diff
          ["gn"] = "]c",
          --jump to prev diff
          ["gp"] = "[c",
        },
        file_panel = {
          ["<leader>q"] = actions.toggle_files,
        },
        file_history_panel = {
          ["<leader>q"] = actions.toggle_files,
        },
      },
    })
  end,
}
