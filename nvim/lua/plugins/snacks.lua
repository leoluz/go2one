return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- highlight LSP references of the word under the cursor
      words = { enabled = true },
    },
    keys = {
      { "]r", function() Snacks.words.jump(vim.v.count1) end, desc = "Next reference" },
      { "[r", function() Snacks.words.jump(-vim.v.count1) end, desc = "Previous reference" },
    },
  },
}
