return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    { "github/copilot.vim" },                       -- or zbirenbaum/copilot.lua
    { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
  },
  build = "make tiktoken",                          -- Only on MacOS or Linux
  opts = {
    prompts = {
      Refactor = {
        prompt = 'Refactor this code extracting it in a function',
        description = 'Copilot Refactor Extract Function',
      },
      Summarize = "Summarize the text.",
      Spelling = "Correct any grammar and spelling errors.",
      Wording = "Improve the grammar and wording.",
      Concise = "Rewrite the text to make it more concise.",
    },
  },
  keys = {
    {
      "<leader>cc",
      function()
        return require("CopilotChat").toggle()
      end,
      mode = { "n", "v" },
      desc = "[C]opilot [C]hat Toggle",
    },
    {
      "<leader>cq",
      function()
        vim.ui.input({
          prompt = "Quick Chat: ",
        }, function(input)
          if input ~= "" then
            require("CopilotChat").ask(input)
          end
        end)
      end,
      mode = { "n", "v" },
      desc = "[C]opilot [Q]uick Chat",
    },
    { "<leader>cx", "<cmd>CopilotChatExplain<cr>",   mode = "v", desc = "[C]opilot E[x]plain Code" },
    { "<leader>cr", "<cmd>CopilotChatReview<cr>",    mode = "v", desc = "[C]opilot [R]eview Code" },
    { "<leader>cf", "<cmd>CopilotChatFix<cr>",       mode = "v", desc = "[C]opilot [F]ix Code" },
    { "<leader>co", "<cmd>CopilotChatOptimize<cr>",  mode = "v", desc = "[C]opilot [O]ptimize Code" },
    { "<leader>cd", "<cmd>CopilotChatDocs<cr>",      mode = "v", desc = "[C]opilot Generate [D]ocs" },
    { "<leader>ct", "<cmd>CopilotChatTests<cr>",     mode = "v", desc = "[C]opilot Generate [T]ests" },
    { "<leader>cm", "<cmd>CopilotChatCommit<cr>",    mode = "n", desc = "[C]opilot Generate Co[m]mit Message" },
    { "<leader>ce", "<cmd>CopilotChatRefactor<cr>",  mode = "v", desc = "[C]opilot Refactor [E]xtract Function" },
    { "<leader>cs", "<cmd>CopilotChatSummarize<cr>", mode = "v", desc = "[C]opilot [S]ummarize Text" },
    { "<leader>cp", "<cmd>CopilotChatSpelling<cr>",  mode = "v", desc = "[C]opilot Check S[p]elling" },
    { "<leader>cw", "<cmd>CopilotChatWording<cr>",   mode = "v", desc = "[C]opilot Improve [W]ording" },
    { "<leader>ci", "<cmd>CopilotChatConcise<cr>",   mode = "v", desc = "[C]opilot Make Text Conc[i]se" },
  },
}
