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

return M
