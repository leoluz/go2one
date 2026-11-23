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
