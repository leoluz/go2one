--Greeter plugin
return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require 'alpha'.setup(require 'alpha.themes.startify'.config)

    -- Close any window still showing the alpha dashboard as soon as
    -- something else (a file, nvim-tree, telescope, etc.) opens in a real
    -- (non-floating) window, so the dashboard doesn't linger behind it.
    vim.api.nvim_create_autocmd("BufWinEnter", {
      callback = function(args)
        if vim.bo[args.buf].filetype == "alpha" then
          return
        end
        local win = vim.api.nvim_get_current_win()
        if vim.api.nvim_win_get_config(win).relative ~= "" then
          return -- ignore floating windows (hover, completion, etc.)
        end
        for _, w in ipairs(vim.api.nvim_list_wins()) do
          if w ~= win and vim.api.nvim_win_is_valid(w) then
            local b = vim.api.nvim_win_get_buf(w)
            if vim.bo[b].filetype == "alpha" then
              pcall(vim.api.nvim_win_close, w, false)
            end
          end
        end
      end,
    })
  end
};
