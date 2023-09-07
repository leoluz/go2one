return {
  "sindrets/diffview.nvim",
  config = function()
    require("diffview").setup({
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
    })
  end,
}
