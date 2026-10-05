return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local gitsigns = require("gitsigns")
    gitsigns.setup {
      signs = {
        add          = { text = "+" },
        change       = { text = "~" },
        delete       = { text = "-" },
        topdelete    = { text = "‾" },
        changedelete = { text = "-" },
        untracked    = { text = '┆' },
      },
      signs_staged = {
        add          = { text = "+" },
        change       = { text = "~" },
        delete       = { text = "-" },
        topdelete    = { text = "‾" },
        changedelete = { text = "-" },
        untracked    = { text = '┆' },
      },
      word_diff = false,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "ghj", function()
          vim.schedule(function()
            gs.nav_hunk("next", { target = "all" })
          end)
          return "<Ignore>"
        end, { expr = true, desc = "next hunk" })

        map("n", "ghk", function()
          vim.schedule(function()
            gs.nav_hunk("prev", { target = "all" })
          end)
          return "<Ignore>"
        end, { expr = true, desc = "previous hunk" })

        -- Actions
        map("n", "ghp", gs.preview_hunk, { expr = false, desc = "preview hunk" })
        map("n", "ghb", function()
          gs.blame_line { full = true }
        end, { expr = false, desc = "blame line" })
        map('n', 'ghd', gs.diffthis, { expr = false, desc = "diff this" })
        map('n', 'ghu', gs.reset_hunk, { expr = false, desc = "reset hunk" })
        -- map('n', 'gh1', gs.change_base('HEAD~1'), { expr = false, desc = "reset hunk" })
        map('n', 'gh1', ':Gitsigns change_base ~1<CR>', { expr = false, desc = "reset hunk" })
        map('n', 'gh0', gs.reset_base, { expr = false, desc = "reset hunk" })
      end,
    }

    -- On every branch switch, diff against the merge base with the upstream
    -- default branch so the signs show only what the branch itself changed.
    local default_branches = { master = true, main = true }
    local base_refs = { "upstream/master", "upstream/main", "origin/master", "origin/main" }
    local last_head = {}

    local function git(root, args)
      local res = vim.system(vim.list_extend({ "git", "-C", root }, args), { text = true }):wait()
      if res.code ~= 0 then
        return nil
      end
      return vim.trim(res.stdout)
    end

    vim.api.nvim_create_autocmd("User", {
      group = vim.api.nvim_create_augroup("gitsigns_branch_base", { clear = true }),
      pattern = "GitSignsUpdate",
      callback = function(ev)
        local buf = ev.data and ev.data.buffer
        local status = buf and vim.b[buf].gitsigns_status_dict
        if not status or not status.root or not status.head then
          return
        end
        if last_head[status.root] == status.head then
          return
        end
        last_head[status.root] = status.head

        if default_branches[status.head] then
          gitsigns.reset_base(true)
          return
        end
        for _, ref in ipairs(base_refs) do
          if git(status.root, { "rev-parse", "--verify", "--quiet", ref }) then
            local base = git(status.root, { "merge-base", "HEAD", ref })
            if base then
              gitsigns.change_base(base, true)
            end
            return
          end
        end
      end,
    })
  end
}
