--- release_diff: Telescope + Diffview for "commits on a release branch not yet released".
---
--- Usage:
---   <leader>gR               Fetch, then pick a release branch (newest first).
---   :ReleaseDiff [branch]    Same, or go straight to [branch] (e.g. release-3.5).
---   :ReleaseDiff!            Skip the fetch.
---
--- The remote is auto-detected: "upstream" is preferred over "origin" (fork checkouts).
--- The baseline is the latest non-rc tag reachable from the branch (git describe), so for
--- release-3.5 it is v3.5.5 once that is tagged, and the commits listed are v3.5.5..release-3.5.
---
--- In the commit picker (telescope's git_commits previewers, cycle with <C-f>/<C-b> by default):
---   <CR>    DiffviewOpen <sha>^!                     diff of the selected commit
---   <C-a>   DiffviewFileHistory --range=<tag>..<br>  browse every unreleased commit
---   <C-o>   DiffviewOpen <tag>..<br>                 aggregated diff of all unreleased changes
local M = {}

local function git(args, cb)
  vim.system(vim.list_extend({ "git" }, args), { cwd = vim.fn.getcwd(), text = true }, function(res)
    vim.schedule(function()
      cb(res.code == 0, vim.trim(res.stdout or ""), vim.trim(res.stderr or ""))
    end)
  end)
end

local function detect_remote(cb)
  git({ "remote" }, function(ok, out)
    if not ok then return cb(nil) end
    local remotes = vim.split(out, "\n", { trimempty = true })
    for _, name in ipairs({ "upstream", "origin" }) do
      if vim.tbl_contains(remotes, name) then return cb(name) end
    end
    cb(nil)
  end)
end

-- Explicit refspecs instead of --tags: upstream moves the "stable" tag on every
-- release, and a plain --tags fetch fails with "would clobber existing tag".
local function fetch(remote, cb)
  vim.notify("release_diff: fetching " .. remote .. "...")
  git({
    "fetch", remote,
    ("+refs/heads/release-*:refs/remotes/%s/release-*"):format(remote),
    "refs/tags/v*:refs/tags/v*",
  }, function(ok, _, err)
    if not ok then vim.notify("release_diff: fetch failed: " .. err, vim.log.levels.WARN) end
    cb()
  end)
end

local function show_commits(branch)
  git({ "describe", "--tags", "--abbrev=0", "--match", "v*", "--exclude", "*-rc*", branch }, function(ok, tag, err)
    if not ok then
      return vim.notify("release_diff: no release tag found on " .. branch .. ": " .. err, vim.log.levels.ERROR)
    end
    local range = tag .. ".." .. branch
    git({ "rev-list", "--count", range }, function(_, count)
      if count == "0" then
        return vim.notify(("release_diff: %s has no commits after %s"):format(branch, tag))
      end
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      require("telescope.builtin").git_commits({
        prompt_title = ("%s (%s commits)"):format(range, count),
        git_command = { "git", "log", "--pretty=oneline", "--abbrev-commit", range },
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            local entry = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            if entry then vim.cmd("DiffviewOpen " .. entry.value .. "^!") end
          end)
          map({ "i", "n" }, "<C-a>", function()
            actions.close(prompt_bufnr)
            vim.cmd("DiffviewFileHistory --range=" .. range)
          end)
          map({ "i", "n" }, "<C-o>", function()
            actions.close(prompt_bufnr)
            vim.cmd("DiffviewOpen " .. range)
          end)
          return true
        end,
      })
    end)
  end)
end

local function pick_branch(remote)
  git({ "for-each-ref", "--sort=-version:refname", "--format=%(refname:short)",
    ("refs/remotes/%s/release-*"):format(remote) }, function(ok, out)
    local branches = vim.split(out, "\n", { trimempty = true })
    if not ok or #branches == 0 then
      return vim.notify("release_diff: no release-* branches on " .. remote, vim.log.levels.ERROR)
    end
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    pickers.new({}, {
      prompt_title = "Release branches (" .. remote .. ")",
      finder = finders.new_table({ results = branches }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local entry = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if entry then show_commits(entry[1]) end
        end)
        return true
      end,
    }):find()
  end)
end

function M.open(opts)
  opts = opts or {}
  detect_remote(function(remote)
    if not remote then
      return vim.notify("release_diff: no upstream/origin remote in " .. vim.fn.getcwd(), vim.log.levels.ERROR)
    end
    local function go()
      if opts.branch then
        local branch = opts.branch:find("/", 1, true) and opts.branch or (remote .. "/" .. opts.branch)
        show_commits(branch)
      else
        pick_branch(remote)
      end
    end
    if opts.fetch == false then go() else fetch(remote, go) end
  end)
end

vim.api.nvim_create_user_command("ReleaseDiff", function(cmd_opts)
  M.open({ branch = cmd_opts.args ~= "" and cmd_opts.args or nil, fetch = not cmd_opts.bang })
end, {
  nargs = "?",
  bang = true,
  desc = "Telescope/Diffview of commits on a release branch since its latest release tag (! skips fetch)",
})

return M
