return {
  {
    { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
    {
      "ravitemer/mcphub.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      build = "npm install -g mcp-hub@latest",
      opts = {},
    },
    {
      "coder/claudecode.nvim",
      dependencies = { "folke/snacks.nvim" },
      config = true,
      keys = {
        { "<leader>c",  nil,                              desc = "Claude Code" },
        { "<leader>cc", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
        { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
        { "<leader>cr", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
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
    },
    {
      "olimorris/codecompanion.nvim",
      enabled = false,
      dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
        { "ravitemer/mcphub.nvim" },
      },
      opts = {
        strategies = {
          chat = {
            -- adapter = "copilot",
            name = "copilot",
            -- model = "Google Gemini 2.5 Pro",
            model = "openai/gpt-5-chat",
            -- model = "Anthropic Claude Opus 4.5",
            -- adapter = {
            --   name = "copilot",
            --   model = "Google Gemini 2.5 Pro",
            -- },
          },
          inline = {
            adapter = "copilot",
          },
          cmd = {
            adapter = "copilot",
          }
        },
        opts = {
          log_level = "DEBUG",
        },
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              -- MCP Tools
              make_tools = true,                    -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
              show_server_tools_in_chat = true,     -- Show individual tools in chat completion (when make_tools=true)
              add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
              show_result_in_chat = true,           -- Show tool results directly in chat buffer
              format_tool = nil,                    -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
              -- MCP Resources
              make_vars = true,                     -- Convert MCP resources to #variables for prompts
              -- MCP Prompts
              make_slash_commands = true,           -- Add MCP prompts as /slash commands
            }
          }
        },
      },
    },
  }
};
