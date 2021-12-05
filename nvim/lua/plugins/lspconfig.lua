local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function()
  vim.api.nvim_set_keymap("n", "<Leader>o", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "gn", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "gp", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", {noremap = true, silent = true})
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

vim.fn.sign_define("LspDiagnosticsSignError", {text="", texthl="LspDiagnosticsSignError", linehl="", numhl=""})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text="", texthl="LspDiagnosticsSignWarning", linehl="", numhl=""})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text="", texthl="LspDiagnosticsSignInformation", linehl="", numhl=""})
vim.fn.sign_define("LspDiagnosticsSignHint", {text="ﯦ", texthl="LspDiagnosticsSignHint", linehl="", numhl=""})

vim.fn.sign_define("DiagnosticSignError", {text="", texthl="DiagnosticSignError", linehl="", numhl=""})
vim.fn.sign_define("DiagnosticSignWarn", {text="", texthl="DiagnosticSignWarn", linehl="", numhl=""})
vim.fn.sign_define("DiagnosticSignInfo", {text="", texthl="DiagnosticSignInfo", linehl="", numhl=""})
vim.fn.sign_define("DiagnosticSignHint", {text="ﯦ", texthl="DiagnosticSignHint", linehl="", numhl=""})

--
-- gopls setup
nvim_lsp.gopls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "gopls",
  },
  flags = {
    debounce_text_changes = 500,
  },
  settings = {
    gopls = {
      usePlaceholders = true, --enables placeholders for function parameters or struct fields in completion responses
    },
  },
}

--
-- sunmeko setup
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  -- assumes the binary can be found in $PATH
  cmd = { "lua-language-server" },
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
