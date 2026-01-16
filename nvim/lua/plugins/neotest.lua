return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      -- "nvim-treesitter/nvim-treesitter",
      -- { "fredrikaverpil/neotest-golang", version = "*" }, -- Installation
      {
        "fredrikaverpil/neotest-golang",
        version = "*",                                                            -- Optional, but recommended; track releases
        build = function()
          vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait() -- Optional, but recommended
        end,
      },
    },
    config = function()
      local neotest_golang_opts = {
        runner = "gotestsum",
        warn_test_name_dupes = false,
      }
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
      { "<leader>tc", function() require("neotest").output_panel.clear() end,                              desc = "[t]est output [c]lear" },
      { "<leader>tS", function() require("neotest").run.stop() end,                                        desc = "[t]est [S]top" },
      { "<leader>td", function() require("neotest").run.run({ suite = false, strategy = "dap" }) end,      desc = "Debug nearest test" },
    },
  },
}
