return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {},
  config = function(_, opts)
    require("trouble").setup(opts)

    local sources = require("trouble.sources")
    -- register raises if the source already exists (e.g. on :Lazy reload)
    if sources.sources.call_tree then
      return
    end

    local max_depth = 15
    local max_requests = 500

    -- unique key for a CallHierarchyItem
    local function key(item)
      local pos = item.selectionRange.start
      return ("%s:%d:%d"):format(item.uri, pos.line, pos.character)
    end

    sources.register("call_tree", {
      config = {
        modes = {
          call_tree = {
            desc = "Incoming call tree",
            title = "{hl:Title}Incoming Call Tree{hl} {count}",
            source = "call_tree",
            -- don't rebuild the tree when the cursor moves in the main window
            events = {},
            groups = {},
            sort = {},
            format = "{kind_icon} {symbol.name} {symbol.detail:Comment} {pos}",
            -- :Trouble call_tree include_tests=true to also show callers in _test.go files
            include_tests = false,
          },
        },
      },
      -- Builds the tree of callers of the function under the cursor by calling
      -- callHierarchy/incomingCalls recursively. Each function is expanded only
      -- once; later occurrences are shown without their callers.
      get = function(cb, ctx)
        local include_tests = ctx.opts.include_tests
        local buf = vim.api.nvim_get_current_buf()
        local win = vim.api.nvim_get_current_win()
        local client = vim.lsp.get_clients({ bufnr = buf, method = "callHierarchy/incomingCalls" })[1]
        if not client then
          return cb({})
        end

        local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
        client:request("textDocument/prepareCallHierarchy", params, function(err, roots)
          if err or not roots or #roots == 0 then
            return cb({})
          end

          local seen = {}
          local pending = 0
          local requests = 0

          local function done()
            pending = pending - 1
            if pending > 0 then
              return
            end
            local items = require("trouble.sources.lsp").results_to_items(client, roots)
            -- the same function can appear in several branches; ids must be
            -- unique so folding works per node
            for i, item in ipairs(items) do
              item.id = item.id .. "|" .. i
            end
            cb(items)
          end

          -- node is the tree entry, item the clean CallHierarchyItem sent to the server
          local function expand(node, item, depth)
            node.children = {}
            seen[key(item)] = true
            if depth >= max_depth or requests >= max_requests then
              return
            end
            pending = pending + 1
            requests = requests + 1
            client:request("callHierarchy/incomingCalls", { item = item }, function(_, calls)
              for _, call in ipairs(calls or {}) do
                if include_tests or not call.from.uri:match("_test%.go$") then
                  local child = vim.deepcopy(call.from)
                  -- jump to the call site instead of the caller's definition
                  child.location = {
                    uri = call.from.uri,
                    range = (call.fromRanges or {})[1] or call.from.selectionRange,
                  }
                  table.insert(node.children, child)
                  if not seen[key(call.from)] then
                    expand(child, call.from, depth + 1)
                  end
                end
              end
              done()
            end, buf)
          end

          for _, root in ipairs(roots) do
            expand(root, vim.deepcopy(root), 0)
          end
        end, buf)
      end,
    })
  end,
  keys = {
    {
      "<leader>xr",
      "<cmd>Trouble lsp_incoming_calls toggle focus=true<cr>",
      desc = "LSP incoming calls"
    },
    {
      "<leader>xR",
      "<cmd>Trouble call_tree toggle focus=true<cr>",
      desc = "LSP incoming call tree"
    },
    {
      "<leader>xo",
      "<cmd>Trouble lsp_outgoing_calls toggle focus=true<cr>",
      desc = "LSP outgoing calls"
    },
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>xs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>xl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
