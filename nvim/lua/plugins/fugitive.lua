return {
  {
    "tpope/vim-fugitive",
    config = function()
      local map = require("utils").map
      local silent = { silent = true }

      map("n", "<leader>gg", ":Git<CR>", silent)
      map("n", "<leader>gc", ":Git commit -s<CR>", silent)
      map("n", "<leader>gp", ":Git push<CR>", silent)

      -- `:Git` always opens the status summary in a fresh split (fugitive's
      -- own s:Mods(..., 'Edge') forces topleft/botright when no explicit
      -- modifier is given) - that part is by design and not worth fighting.
      -- The actual complaint is BlurStatus(): fugitive's internal function
      -- that runs on every <CR> in that buffer and deliberately jumps to (or
      -- creates) a *different* window to open the selected file in, leaving
      -- the status split behind untouched - so it never goes away. Fix: let
      -- fugitive's own <CR> mapping run exactly as it would (captured via
      -- maparg so its behavior, whatever the current fugitive version does,
      -- isn't reimplemented here), and afterward close the status window
      -- ourselves if it's still showing the status buffer (i.e. a file was
      -- actually opened elsewhere). If <CR> was pressed on a blank line or
      -- section header, GF() returns nothing, nothing opens, and the status
      -- window is left alone.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fugitive",
        callback = function(args)
          vim.opt_local.bufhidden = "wipe"
          if vim.b.fugitive_type ~= "index" then
            return
          end

          local orig = vim.fn.maparg("<CR>", "n", false, 1)
          if orig.buffer ~= 1 or orig.rhs == nil or orig.rhs == "" then
            return
          end
          local sid = orig.sid

          vim.keymap.set("n", "<CR>", function()
            local status_win = vim.api.nvim_get_current_win()
            local status_buf = vim.api.nvim_get_current_buf()

            local ok, cmd = pcall(vim.fn["<SNR>" .. sid .. "_GF"], "edit")
            if not (ok and cmd and cmd ~= "") then
              return
            end
            vim.cmd(cmd)

            if vim.api.nvim_win_is_valid(status_win)
              and vim.api.nvim_win_get_buf(status_win) == status_buf then
              pcall(vim.api.nvim_win_close, status_win, false)
            end
          end, { buffer = args.buf, silent = true })
        end,
      })
    end,
  },
  {
    -- :GBrowse from fugitive.vim to open GitHub URLs
    "tpope/vim-rhubarb",
    config = function()
      local map = require("utils").map
      local silent = { silent = true }
      map("n", "<leader>gh", ":GBrowse<CR>", silent)
    end,
  }
}
