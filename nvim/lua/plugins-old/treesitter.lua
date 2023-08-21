require "nvim-treesitter.configs".setup {
  --ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = function(lang, bufnr)
      -- uncomment the line bellow once this is fixed:
      -- https://github.com/nvim-treesitter/nvim-treesitter/issues/2539
      -- return vim.api.nvim_buf_line_count(bufnr) > 10000
    end,
  },
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
}
