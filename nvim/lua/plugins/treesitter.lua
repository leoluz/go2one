return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = { "lua", "vim", "vimdoc", "query", "javascript", "html", "go", "bash" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        refactor = {
          highlight_current_scope = { enable = false },
          highlight_definitions = { enable = true },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gs",
            node_incremental = "gj",
            scope_incremental = "gl",
            node_decremental = "gk",
          },
        },
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        }
      })
    end
  },
  {
    "nvim-treesitter/playground",
    dependencies = {
      "nvim-treesitter",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-refactor",
    dependencies = {
      "nvim-treesitter",
    },
  }
}
