return { 
  {
    "catppuccin/nvim", 
    name = "catppuccin",
    priority = 1000,
    config = function()
      local catppuccin = require("catppuccin")
      catppuccin.setup(
        {
          flavour = "macchiato", -- latte, frappe, macchiato, mocha
          transparent_background = true,
          background = { -- :h background
            light = "latte",
            dark = "macchiato",
          },
          term_colors = false,
          styles = {
            comments = {"italic"},
            functions = {"italic"},
            keywords = {"italic"},
            strings = {},
            variables = {},
          },
          dim_inactive = {
            enabled = true,
            shade = "dark",
            percentage = 0.15,
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
      vim.cmd.colorscheme "catppuccin"
    end,
  },

  {
    "EdenEast/nightfox.nvim",
    enabled = false,
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
  {
    "navarasu/onedark.nvim",
    enabled = false,
  },
  {
    "rakr/vim-one",
    enabled = false,
  },
  {
    "olimorris/onedarkpro.nvim",
    enabled = false,
  },
}
