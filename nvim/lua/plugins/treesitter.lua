return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    lazy = false,
    config = function()
      local ts = require("nvim-treesitter")
      ts.install({ "lua", "vim", "vimdoc", "query", "javascript", "html", "go", "bash", "json", "yaml", "starlark" })

      -- Tiltfiles are Starlark; nvim-treesitter only maps starlark to bzl.
      vim.treesitter.language.register("starlark", "tiltfile")

      -- enable syntax highlighting by filetype
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { "lua", "vim", "vimdoc", "query", "javascript", "html", "go", "bash", "json", "yaml", "sh", "tiltfile" },
        callback = function() vim.treesitter.start() end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = {
      "nvim-treesitter",
    },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")
      local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

      -- select: af/if (function), ac/ic (class), aa/ia (parameter)
      local objects = {
        af = "@function.outer",
        ["if"] = "@function.inner",
        ac = "@class.outer",
        ic = "@class.inner",
        aa = "@parameter.outer",
        ia = "@parameter.inner",
      }
      for lhs, query in pairs(objects) do
        vim.keymap.set({ "x", "o" }, lhs, function() select.select_textobject(query, "textobjects") end,
          { desc = "Select " .. query })
      end

      -- move: ]m/[m to function start, ]M/[M to function end
      vim.keymap.set({ "n", "x", "o" }, "]m", function() move.goto_next_start("@function.outer", "textobjects") end,
        { desc = "Next function start" })
      vim.keymap.set({ "n", "x", "o" }, "[m", function() move.goto_previous_start("@function.outer", "textobjects") end,
        { desc = "Previous function start" })
      vim.keymap.set({ "n", "x", "o" }, "]M", function() move.goto_next_end("@function.outer", "textobjects") end,
        { desc = "Next function end" })
      vim.keymap.set({ "n", "x", "o" }, "[M", function() move.goto_previous_end("@function.outer", "textobjects") end,
        { desc = "Previous function end" })

      -- Repeat movement with ; and ,
      -- ensure ; goes forward and , goes backward regardless of the last direction
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

      -- make builtin f, F, t, T also repeatable with ; and ,
      vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
    end
  },
}
