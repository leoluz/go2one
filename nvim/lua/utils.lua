local M = {}

-- map is a nvim_set_keymap wrapper function that applies pre-defined options
function M.map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- auto_format_lsp will format current buffer if it has lsp client attached
-- with 'document_formatting' capability
function M.auto_format_lsp()
  local id, client = next(vim.lsp.buf_get_clients())
  if id ~= nil and client.resolved_capabilities.document_formatting then
    vim.lsp.buf.formatting_sync(nil, 100)
  end
end

function M.reload(module_name)
  local function match(pkg)
    return string.find(pkg, module_name, 1, true)
  end

  for p, _ in pairs(package.loaded) do
    if match(p) then
      package.loaded[p] = nil
    end
  end
  print("module "..module_name.." reloaded!")
end

return M
