-- Kill the running Claude terminal (if any) and start a new one with args.
-- close() only kills the job; the plugin forgets the terminal in its TermClose
-- handler, which runs later. Opening before that reuses the dying terminal
-- (and its late TermClose clears the new one), so wait for it first.
local function claude_restart(args)
  local term = require("claudecode.terminal")
  if term.get_active_terminal_bufnr() then
    term.close()
    vim.wait(2000, function() return term.get_active_terminal_bufnr() == nil end, 10)
  end
  vim.cmd("ClaudeCode " .. args)
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
        { "<leader>cc", "<cmd>ClaudeCode<cr>",      desc = "Toggle Claude" },
        -- On-call modes. The mode files come from dot_files_macos (modules/claude-oncall.nix).
        -- claudecode.nvim reuses a running terminal and ignores new args, so close it first.
        {
          "<leader>cr",
          function() claude_restart("--settings ~/.claude/oncall-ro.json") end,
          desc = "On-call (read-only)",
        },
        {
          "<leader>cw",
          function() claude_restart("--settings ~/.claude/oncall-rw.json") end,
          desc = "On-call (write access)",
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
              claude_hide = { "<C-,>", function(self) self:hide() end, mode = "t", desc = "Hide" },
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
