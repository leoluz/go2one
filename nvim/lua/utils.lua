local M = {}

---map is a nvim_set_keymap wrapper function that applies pre-defined options
---@param mode string|table
---@param lhs string
---@param rhs string|function
---@param opts table|nil
function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

---Will reload the given module_name
---@param module_name string
function M.reload(module_name)
  local function match(pkg)
    return string.find(pkg, module_name, 1, true)
  end

  for p, _ in pairs(package.loaded) do
    if match(p) then
      package.loaded[p] = nil
    end
  end
  print("module " .. module_name .. " reloaded!")
end

return M
