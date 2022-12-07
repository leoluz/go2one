local gs = require("gitsigns")
gs.setup {
  signs = {
    add = { hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  word_diff = true,
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "next hunk" })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "previous hunk" })

    -- Actions
    map("n", "<leader>hp", gs.preview_hunk)
    map("n", "<leader>hb", function()
      gs.blame_line { full = true }
    end)
  end,
}

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = "*",
  callback = function()
    vim.cmd [[
      hi GitSignsChangeInline gui=reverse
      hi GitSignsAddInline gui=reverse
      hi GitSignsDeleteInline gui=reverse
    ]]
  end
})


-- gitsigns.setup {
--   signs = {
--     add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
--     change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
--     delete       = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
--     topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
--     changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
--   },
--   signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
--   numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
--   linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
--   word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
--   keymaps = {
--     -- Default keymap options
--     noremap = true,
-- 
--     ['n ghj'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
--     ['n ghk'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},
--     ['n ghr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
--     ['n ghR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
--     ['n ghp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
--     ['n ghb'] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
--     --
--     ['n ghs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
--     ['v ghs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
--     ['n ghu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
--     ['v ghr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
--     ['n ghS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
--     ['n ghU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',
-- 
--     -- Text objects
--     ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
--     ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
--   },
--   watch_gitdir = {
--     interval = 1000,
--     follow_files = true
--   },
--   attach_to_untracked = true,
--   current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
--   current_line_blame_opts = {
--     virt_text = true,
--     virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
--     delay = 1000,
--     ignore_whitespace = false,
--   },
--   current_line_blame_formatter_opts = {
--     relative_time = false
--   },
--   sign_priority = 6,
--   update_debounce = 100,
--   status_formatter = nil, -- Use default
--   max_file_length = 40000,
--   preview_config = {
--     -- Options passed to nvim_open_win
--     border = 'single',
--     style = 'minimal',
--     relative = 'cursor',
--     row = 0,
--     col = 1
--   },
--   yadm = {
--     enable = false
--   },
-- }
