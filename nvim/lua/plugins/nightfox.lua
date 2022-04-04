local nightfox = require('nightfox')

-- This function set the configuration of nightfox. If a value is not passed in the setup function
-- it will be taken from the default configuration above
nightfox.setup({
  options = {
    transparent = true,
    terminal_colors = true,
    styles = {
      comments = "italic", -- change style of comments to be italic
      keywords = "bold", -- change style of keywords to be bold
      strings = "italic", -- Style that is applied to strings: see `highlight-args` for options
      functions = "NONE", -- styles can be a comma separated list
      variables = "NONE", -- Style that is applied to variables: see `highlight-args` for options
    },
    inverse = {
      match_paren = true, -- inverse the highlighting of match_parens
      visual = false, -- Enable/Disable inverse highlighting for visual selection
      search = false, -- Enable/Disable inverse highlights for search highlights
    },
  },
  palettes = {
    nightfox = {
      gitSigns = {
        add    = "#7fab61",
        change = "#dbc074",
        delete = "#f17f29",
      },
      git = {
        add    = "#7fab61",
        change = "#dbc074",
        delete = "#d15828",
        conflict = "#dbc074",
      },
      -- diff = {
        -- add    = "#7fab6k",
        -- change = "#dbc074",
        -- delete = "#f17f29",
      -- },
      red        = "#e66060",
      green      = "#7fab61",
      cyan       = "#9d79d6",
      pink       = "#cc77c5",

      -- https://coolors.co/393b44-e66060-7fab61-f4a261-dbc074-719cd6-9d79d6-7b64ce-cc77c5-dfdfe0
      -- default
      -- black      = "#393b44",
      -- red        = "#c94f6d",
      -- green      = "#81b29a",
      -- orange     = "#f4a261",
      -- yellow     = "#dbc074",
      -- blue       = "#719cd6",
      -- magenta    = "#9d79d6",
      -- cyan       = "#63cdcf",
      -- pink       = "#d67ad2",
      -- white      = "#dfdfe0",
    }
  },
  groups = {
    TSProperty = { fg = "palette.pink" },
    TSKeywordFunction = { fg = "palette.pink" },
    Identifier = { fg = "palette.cyan" },
    dashboardHeader = { fg = "palette.green"},
    -- GitSignsDeleteLn = { fg = "${red}" },
    -- TSPunctDelimiter = { fg = "${red}" }, -- Override a highlight group with the color red
    -- LspCodeLens = { bg = "#000000", style = "italic" },
  }
})

vim.cmd [[colorscheme nightfox]]
