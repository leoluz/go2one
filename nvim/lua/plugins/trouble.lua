return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {},
  keys = {
    {
      "<leader>xr",
      "<cmd>Trouble lsp_incoming_calls toggle focus=true<cr>",
      desc = "LSP incoming calls"
    },
    {
      "<leader>xo",
      "<cmd>Trouble lsp_outgoing_calls toggle focus=true<cr>",
      desc = "LSP outgoing calls"
    },
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>xs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>xl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
