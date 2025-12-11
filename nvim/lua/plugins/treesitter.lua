return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    lazy = false,
    config = function()
      local ts = require("nvim-treesitter")
      ts.install({ "lua", "vim", "vimdoc", "query", "javascript", "html", "go", "bash", "json", "yaml" })

      -- enable syntax highlighting by filetype
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { "lua", "vim", "vimdoc", "query", "javascript", "html", "go", "bash", "json", "yaml", "sh" },
        callback = function() vim.treesitter.start() end,
      })
    end,
  },

  -- {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --   dependencies = {
  --     "nvim-treesitter",
  --   },
  --   config = function()
  --     local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
  --
  --     -- Repeat movement with ; and ,
  --     -- ensure ; goes forward and , goes backward regardless of the last direction
  --     vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
  --     vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
  --
  --     -- vim way: ; goes to the direction you were moving.
  --     -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
  --     -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
  --
  --     -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
  --     vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
  --     vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
  --     vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
  --     vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
  --   end
  -- },
  -- {
  --   "nvim-treesitter/playground",
  --   dependencies = {
  --     "nvim-treesitter",
  --   },
  -- },
  -- {
  --   "nvim-treesitter/nvim-treesitter-refactor",
  --   -- generates a terrible input lag on large files
  --   -- I had to disable it for now
  --   enabled = false,
  --   dependencies = {
  --     "nvim-treesitter",
  --   },
  -- }
}
