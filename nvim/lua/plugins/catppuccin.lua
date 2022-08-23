local catppuccin = require("catppuccin")
-- local cp = require("catppuccin.core.color_palette")

catppuccin.setup(
{
  transparent_background = true,
  term_colors = false,
  styles = {
    comments = {"italic"},
    functions = {"italic"},
    keywords = {"italic"},
    strings = {},
    variables = {},
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = {"italic"},
        hints = {"italic"},
        warnings = {"italic"},
        information = {"italic"},
      },
      underlines = {
        errors = {"underline"},
        hints = {"underline"},
        warnings = {"underline"},
        information = {"underline"},
      },
    },
    lsp_trouble = false,
    cmp = true,
    lsp_saga = false,
    gitgutter = false,
    gitsigns = true,
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
    bufferline = true,
    neogit = false,
    vim_sneak = false,
    fern = false,
    barbar = false,
    markdown = true,
    lightspeed = false,
    ts_rainbow = false,
    hop = false,
    notify = false,
    telekasten = false,
    symbols_outline = true,
  },
}
)

vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
vim.cmd[[colorscheme catppuccin]]
-- vim.cmd [[colorscheme catppuccin]]
-- vim.cmd("highlight DashboardHeader guifg="..cp.catppuccin3)
