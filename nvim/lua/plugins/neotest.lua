return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "fredrikaverpil/neotest-golang", version = "*" }, -- Installation
    },
    config = function()
      local neotest_golang_opts = {
        runner = "go",
        go_test_args = function()
          return { "-count=1" }
        end,
      } -- Specify custom configuration
      require("neotest").setup({
        adapters = {
          require("neotest-golang")(neotest_golang_opts),
        },
      })
    end,
    keys = {
      { "<leader>ta", function() require("neotest").run.attach() end,                                      desc = "[t]est [a]ttach" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,                       desc = "[t]est run [f]ile" },
      { "<leader>ts", function() require("neotest").run.run({ suite = true }) end,                         desc = "[t]est [s]uite" },
      { "<leader>tt", function() require("neotest").run.run() end,                                         desc = "[t]est neares[t]" },
      { "<leader>tl", function() require("neotest").run.run_last() end,                                    desc = "[t]est [l]ast" },
      { "<leader>to", function() require("neotest").summary.toggle() end,                                  desc = "[t]est [s]ummary" },
      { "<leader>tr", function() require("neotest").output.open({ enter = false, auto_close = true }) end, desc = "[t]est [r]esult" },
      { "<leader>tp", function() require("neotest").output_panel.toggle() end,                             desc = "[t]est output [p]anel" },
      { "<leader>tS", function() require("neotest").run.stop() end,                                        desc = "[t]est [S]top" },
      { "<leader>td", function() require("neotest").run.run({ suite = false, strategy = "dap" }) end,      desc = "Debug nearest test" },
    },
  },
}
