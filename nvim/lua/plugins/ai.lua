return {
  {
    {
      "ravitemer/mcphub.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      build = "npm install -g mcp-hub@latest",
      opts = {},
    },
    {
      "olimorris/codecompanion.nvim",
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
