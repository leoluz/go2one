-- Stop the running Claude session (if any) and start a new one with args.
-- claudecode.nvim reuses a running terminal and ignores new args, so the old
-- one must be gone first. Ask Claude to /exit so it quits cleanly (exit 0, no
-- error); if it doesn't (e.g. busy mid-response), kill it with close().
local function claude_restart(args)
  local term = require("claudecode.terminal")
  local gone = function() return term.get_active_terminal_bufnr() == nil end
  if not gone() then
    term.send_to_terminal("/exit")
    if not vim.wait(3000, gone, 20) then
      term.close()
      vim.wait(2000, gone, 10)
    end
  end
  vim.cmd("ClaudeCode " .. args)
end

local function switch_to_previous_buffer()
  if vim.fn.buflisted(vim.fn.bufnr("#")) == 1 then
    vim.cmd("buffer #")
  else
    vim.cmd("bprevious")
  end
end

-- Show the Claude terminal buffer in the current window instead of the float.
-- It's the same session the <C-,> float uses; starts one if none is running.
local function claude_in_current_window()
  local term = require("claudecode.terminal")
  local target_win = vim.api.nvim_get_current_win()
  local buf = term.get_active_terminal_bufnr()
  if not buf then
    vim.cmd("ClaudeCodeOpen")
    vim.wait(2000, function() return term.get_active_terminal_bufnr() ~= nil end, 10)
    buf = term.get_active_terminal_bufnr()
    if not buf then
      vim.notify("Claude Code terminal did not start", vim.log.levels.ERROR)
      return
    end
  end
  -- Hide the float if it's showing, so the buffer isn't displayed twice.
  -- ClaudeCodeFocus from inside the float hides it (and its backdrop).
  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    local cfg = vim.api.nvim_win_get_config(win)
    if cfg.relative ~= "" and not cfg.hide then
      vim.api.nvim_set_current_win(win)
      vim.cmd("ClaudeCodeFocus")
    end
  end
  if vim.api.nvim_win_get_config(target_win).relative ~= "" then
    target_win = vim.fn.win_getid(vim.fn.winnr("#"))
  end
  vim.api.nvim_set_current_win(target_win)
  vim.api.nvim_win_set_buf(target_win, buf)
  vim.cmd("startinsert")
end

return {
  {
    {
      "coder/claudecode.nvim",
      dependencies = { "folke/snacks.nvim" },
      config = true,
      keys = {
        { "<C-,>",      "<cmd>ClaudeCodeFocus<cr>", desc = "Claude Code",  mode = { "n", "x" } },
        { "<leader>c",  nil,                        desc = "Claude Code" },
        { "<leader>cc", claude_in_current_window,  desc = "Claude in current window" },
        -- On-call modes. The mode files come from dot_files_macos (modules/claude-oncall.nix).
        {
          "<leader>cr",
          function() claude_restart("--settings ~/.claude/oncall-ro.json") end,
          desc = "Claude On-call (read-only)",
        },
        {
          "<leader>cw",
          function() claude_restart("--settings ~/.claude/oncall-rw.json") end,
          desc = "Claude On-call (write access)",
        },
        { "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
        { "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
        { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
        { "<leader>cs", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                  desc = "Send to Claude" },
        {
          "<leader>cs",
          "<cmd>ClaudeCodeTreeAdd<cr>",
          desc = "Add file",
          ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
        },
        -- Diff management
        { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
        { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
      },
      opts = {
        terminal = {
          snacks_win_opts = {
            position = "float",
            width = 0.95,
            height = 0.95,
            border = "rounded",
            auto_close = true,
            keys = {
              -- In the float: hide it. In a standalone buffer (<leader>cc):
              -- go back to the previous buffer, keeping Claude alive.
              claude_hide = {
                "<C-,>",
                function(self)
                  if vim.api.nvim_win_get_config(0).relative ~= "" then
                    self:hide()
                  else
                    vim.cmd("stopinsert")
                    switch_to_previous_buffer()
                  end
                end,
                mode = "t",
                desc = "Hide",
              },
            },
          },
        },
        diff_opts = {
          layout = "vertical",         -- "vertical" or "horizontal"
          open_in_new_tab = true,
          keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens
          hide_terminal_in_new_tab = true,
          -- on_new_file_reject = "keep_empty", -- "keep_empty" or "close_window"
        },
      },
    },
  }
};
