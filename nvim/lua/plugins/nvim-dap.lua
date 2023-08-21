return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("dap")
      local map = require("utils").map
      local silent = { silent = true }

      vim.fn.sign_define('DapStopped', { text = '▸', texthl = '', linehl = 'debugPC', numhl = '' })
      vim.fn.sign_define('DapBreakpoint', { text = '🔵', texthl = '', linehl = '', numhl = '' })

      map("n", "<F7>", ":lua require'dap'.toggle_breakpoint()<CR>", silent)
      map("n", "<F8>", ":lua require'dap'.continue()<CR>", silent)
      map("n", "<F9>", ":lua require'dap'.step_over()<CR>", silent)
      map("n", "<F10>", ":lua require'dap'.step_into()<CR>", silent)
      map("n", "<F11>", ":lua require'dap'.step_out()<CR>", silent)
      map("n", "<leader>i", ":lua require'dapui'.eval()<CR>", silent)
      map("n", "<leader>du", ":lua require'dapui'.toggle()<CR>", silent)
      map("n", "<leader>dc", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
      map("n", "<leader>di", ":lua require'dap'.step_into()<CR>")
      map("n", "<leader>do", ":lua require'dap'.step_over()<CR>")
      map("n", "<leader>dd", ":lua require'dap'.continue()<CR>")
      map("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>")


      -- TODO explore those functions
      --<leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
      --<leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
      --<leader>i :lua require'dap.ui.widgets'.hover()<CR>
      --<leader>dl :lua require'dap'.run_last()<CR>
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      local dapui = require("dapui")

      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        -- Expand lines larger than the window
        -- Requires >= 0.7
        expand_lines = vim.fn.has("nvim-0.7"),
        -- Layouts define sections of the screen to place windows.
        -- The position can be "left", "right", "top" or "bottom".
        -- The size specifies the height/width depending on position. It can be an Int
        -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
        -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
        -- Elements are the elements shown in the layout (in order).
        -- Layouts are opened in order so that earlier layouts take priority in window sizing.
        layouts = {
          {
            elements = {
              -- Elements can be strings or table with id and size keys.
              { id = "scopes", size = 0.25 },
              "breakpoints",
              "stacks",
              "watches",
            },
            size = 40, -- 40 columns
            position = "left",
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
          },
        },
        controls = {
          -- Requires Neovim nightly (or 0.8 when released)
          enabled = true,
          -- Display controls in this element
          element = "repl",
          icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "↻",
            terminate = "□",
          },
        },
        floating = {
          max_height = nil,  -- These can be integers or a float between 0 and 1.
          max_width = nil,   -- Floats will be treated as percentage of your screen.
          border = "single", -- Border style. Can be "single", "double" or "rounded"
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil, -- Can be integer or nil.
          max_value_lines = 100, -- Can be integer or nil.
        }
      })
    end
  },
  {
    "leoluz/nvim-dap-go",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      local dapgo = require('dap-go')
      local map = require("utils").map
      local silent = { silent = true }

      require('dap-go').setup {
        delve = {
          initialize_timeout_sec = 30,
        },
      }
      map("n", "<leader>y", dapgo.debug_test, silent)
    end
  },
}
