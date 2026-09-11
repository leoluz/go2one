--- gh_reviews: Telescope picker for "PRs I've reviewed on GitHub".
---
--- Usage:
---   <leader>gr              Open the picker for the current repo, reviewer = your own gh login.
---   :GhReviewedPRs [login]  Same, but for a specific reviewer (defaults to your own gh login).
---
--- Repo is auto-detected from git remotes in the current working directory: "upstream" is
--- preferred over "origin" (so it works from a fork checkout, where "origin" is your own fork
--- and has no PRs/reviews on it). Requires the "gh" CLI to be installed and authenticated.
---
--- In the picker: type to fuzzy-filter, <CR> opens the selected PR in your browser.
---
--- Caveat: the date shown per row is the PR's own "last updated" timestamp (GitHub's search API
--- has no "date I reviewed" field/sort), so it reflects the most recent activity from anyone on
--- the PR (a new commit, a bot comment, etc.), not necessarily when the listed reviewer reviewed
--- it. A PR can show as recently updated even if that reviewer's own review is old.
local M = {}

local function remote_repo(cwd, remote, cb)
  vim.system({ "git", "remote", "get-url", remote }, { cwd = cwd, text = true }, function(res)
    vim.schedule(function()
      if res.code ~= 0 then return cb(nil) end
      local url = vim.trim(res.stdout)
      local owner_repo = url:match("github%.com[:/]([%w_.-]+/[%w_.-]+)")
      if owner_repo then owner_repo = owner_repo:gsub("%.git$", "") end
      cb(owner_repo)
    end)
  end)
end

-- Prefer "upstream" over "origin": for a fork checkout, "origin" is the
-- user's own fork (usually with no PRs/reviews on it) while "upstream" is
-- the real project being reviewed.
local function detect_repo(cwd, cb)
  remote_repo(cwd, "upstream", function(repo)
    if repo then return cb(repo) end
    remote_repo(cwd, "origin", cb)
  end)
end

local function current_gh_user(cb)
  vim.system({ "gh", "api", "user", "--jq", ".login" }, { text = true }, function(res)
    vim.schedule(function()
      if res.code ~= 0 then return cb(nil) end
      cb(vim.trim(res.stdout))
    end)
  end)
end

local function fetch(repo, reviewer, on_done)
  vim.system({
    "gh", "search", "prs",
    "--repo", repo,
    "--reviewed-by", reviewer,
    "--sort", "updated",
    "--order", "desc",
    "--limit", "100",
    "--json", "number,title,url,state,updatedAt",
  }, { text = true }, function(res)
    vim.schedule(function()
      if res.code ~= 0 then
        vim.notify("gh_reviews: " .. (res.stderr or "gh command failed"), vim.log.levels.ERROR)
        return on_done(nil)
      end
      local ok, data = pcall(vim.json.decode, res.stdout)
      if not ok then
        vim.notify("gh_reviews: failed to parse gh output", vim.log.levels.ERROR)
        return on_done(nil)
      end
      on_done(data)
    end)
  end)
end

local function open_picker(items, repo, reviewer)
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers.new({}, {
    prompt_title = ("Reviewed PRs: %s @ %s"):format(reviewer, repo),
    finder = finders.new_table({
      results = items,
      entry_maker = function(pr)
        return {
          value = pr,
          display = string.format("#%-6d %-8s %-10s %s", pr.number, pr.state, pr.updatedAt:sub(1, 10), pr.title),
          ordinal = pr.number .. " " .. pr.title,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if entry then vim.ui.open(entry.value.url) end
      end)
      return true
    end,
  }):find()
end

local function run(repo, reviewer)
  fetch(repo, reviewer, function(items)
    if not items then return end
    if #items == 0 then
      return vim.notify("No reviewed PRs found for " .. reviewer .. " in " .. repo, vim.log.levels.WARN)
    end
    open_picker(items, repo, reviewer)
  end)
end

function M.reviewed_prs(opts)
  opts = opts or {}
  detect_repo(vim.fn.getcwd(), function(repo)
    if not repo then
      return vim.notify("gh_reviews: no github.com origin remote found in " .. vim.fn.getcwd(), vim.log.levels.ERROR)
    end
    if opts.reviewer then
      run(repo, opts.reviewer)
    else
      current_gh_user(function(reviewer)
        if not reviewer then
          return vim.notify("gh_reviews: couldn't determine the authenticated gh user", vim.log.levels.ERROR)
        end
        run(repo, reviewer)
      end)
    end
  end)
end

vim.api.nvim_create_user_command("GhReviewedPRs", function(cmd_opts)
  M.reviewed_prs({ reviewer = cmd_opts.args ~= "" and cmd_opts.args or nil })
end, {
  nargs = "?",
  desc = "List PRs reviewed by [login] (default: yourself) in the repo detected from cwd, in a Telescope picker",
})

return M
