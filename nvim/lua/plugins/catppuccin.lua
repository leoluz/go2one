local catppuccin = require("catppuccin")
local cp = require("catppuccin.core.color_palette")

-- configure it
catppuccin.setup(
{
  transparent_background = true,
  term_colors = false,
  styles = {
    comments = "italic",
    functions = "italic",
    keywords = "italic",
    strings = "NONE",
    variables = "NONE",
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = "italic",
        hints = "italic",
        warnings = "italic",
        information = "italic",
      },
      underlines = {
        errors = "underline",
        hints = "underline",
        warnings = "underline",
        information = "underline",
      },
    },
    lsp_trouble = false,
    lsp_saga = false,
    gitgutter = false,
    gitsigns = false,
    telescope = true,
    nvimtree = {
      enabled = true,
      show_root = false,
    },
    which_key = false,
    indent_blankline = {
      enabled = false,
      colored_indent_levels = false,
    },
    dashboard = true,
    neogit = false,
    vim_sneak = false,
    fern = false,
    barbar = false,
    bufferline = true,
    markdown = true,
    lightspeed = false,
    ts_rainbow = false,
    hop = false,
  },
}
)

vim.cmd [[colorscheme catppuccin]]
vim.cmd("highlight DashboardHeader guifg="..cp.catppuccin3)
