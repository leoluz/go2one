return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      local bufferline = require("bufferline")
      local map = require("utils").map
      local silent = { silent = true }
      bufferline.setup {
        options = {
          numbers = "ordinal",
          close_command = "bdelete! %d",
          buffer_close_icon = '',
          modified_icon = '●',
          close_icon = '',
          left_trunc_marker = '',
          right_trunc_marker = '',

          show_buffer_icons = true,
          show_buffer_close_icons = false,
          show_close_icon = false,
          show_tab_indicators = false,
          persist_buffer_sort = true,
          --separator_style = "slant" | "thick" | "thin" | { 'any', 'any' },
          separator_style = "thick",
          enforce_regular_tabs = false,
          always_show_bufferline = false,
        }
      }
      map("n", "<C-l>", ":BufferLineCycleNext<CR>", silent)
      map("n", "<C-h>", ":BufferLineCyclePrev<CR>", silent)
      map("n", "<C-k>", ":BufferLineMoveNext<CR>", silent)
      map("n", "<C-j>", ":BufferLineMovePrev<CR>", silent)
      map("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", silent)
      map("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", silent)
      map("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", silent)
      map("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", silent)
      map("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", silent)
      map("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", silent)
      map("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", silent)
      map("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", silent)
      map("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", silent)
    end
  },
}
