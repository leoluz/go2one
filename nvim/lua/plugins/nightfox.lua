local nightfox = require('nightfox')

-- This function set the configuration of nightfox. If a value is not passed in the setup function
-- it will be taken from the default configuration above
nightfox.setup({
  fox = "nightfox", -- change the colorscheme to use nordfox
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
  colors = {
    gitSigns = {
      add    = "#81b29a",
      change = "#dbc074",
      delete = "#f17f29",
    },
    red        = "#f17f29",
    green      = "#67b99a",
    cyan       = "#97d3df",
    pink       = "#cbb2fe",
    -- black      = "#393b44",
    -- green      = "#81b29a",
    -- yellow     = "#dbc074",
    -- blue       = "#719cd6",
    -- magenta    = "#9d79d6",
    -- cyan       = "#63cdcf",
    -- white      = "#dfdfe0",
    -- orange     = "#f4a261",
    -- pink       = "#d67ad2",
  },
  hlgroups = {
    TSProperty = { fg = "${pink}" },
    GitSignsDeleteLn = { fg = "${red}" }
    -- TSPunctDelimiter = { fg = "${red}" }, -- Override a highlight group with the color red
    -- LspCodeLens = { bg = "#000000", style = "italic" },
  }
})

-- Load the configuration set above and apply the colorscheme
nightfox.load()
