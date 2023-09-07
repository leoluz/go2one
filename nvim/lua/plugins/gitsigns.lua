return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local gitsigns = require("gitsigns")
    gitsigns.setup {
      signs = {
        add = { hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        changedelete = { hl = "GitSignsChange", text = "_", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
      },
      word_diff = false,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "ghj", function()
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "next hunk" })

        map("n", "ghk", function()
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "previous hunk" })

        -- Actions
        map("n", "ghp", gs.preview_hunk, { expr = false, desc = "preview hunk" })
        map("n", "ghb", function()
          gs.blame_line { full = true }
        end, { expr = false, desc = "blame line" })
        map('n', 'ghd', gs.diffthis, { expr = false, desc = "diff this" })
        map('n', 'ghu', gs.reset_hunk, { expr = false, desc = "reset hunk" })
      end,
    }
  end
}
