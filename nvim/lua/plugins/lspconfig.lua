-- DEPRECATED IN FAVOR OF LSP-ZERO
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local map = require("utils").map
local builtin = require('telescope.builtin')
local lspbuf = vim.lsp.buf

local opt = { noremap = true, silent = true }

local on_attach = function()
  map("n", "<leader>fs", builtin.lsp_dynamic_workspace_symbols, opt)
  map("n", "gr", builtin.lsp_references, opt)
  map("n", "gi", builtin.lsp_implementations, opt)
  map("n", "<leader>o", builtin.lsp_document_symbols, opt)
  map("n", "ga", lspbuf.code_action, opt)
  map("n", "gd", lspbuf.definition, opt)
  map("n", "gD", lspbuf.declaration, opt)
  map("n", "gt", vim.lsp.buf.type_definition, opt)

  map("n", "gn", vim.diagnostic.goto_next, opt)
  map("n", "gp", vim.diagnostic.goto_prev, opt)

  map("n", "<Leader>rn", vim.lsp.buf.rename, opt)
  map("n", "K", vim.lsp.buf.hover, opt)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = false,
  signs = true,
  update_in_insert = false,
}
)

vim.fn.sign_define("LspDiagnosticsSignError", { text = "", texthl = "LspDiagnosticsSignError", linehl = "", numhl = "" })
vim.fn.sign_define("LspDiagnosticsSignWarning", { text = "", texthl = "LspDiagnosticsSignWarning", linehl = "",
  numhl = "" })
vim.fn.sign_define("LspDiagnosticsSignInformation",
  { text = "", texthl = "LspDiagnosticsSignInformation", linehl = "", numhl = "" })
vim.fn.sign_define("LspDiagnosticsSignHint", { text = "ﯦ", texthl = "LspDiagnosticsSignHint", linehl = "", numhl = "" })
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
vim.fn.sign_define("DiagnosticSignHint", { text = "ﯦ", texthl = "DiagnosticSignHint", linehl = "", numhl = "" })

---------------
-- Go Configs
-- gopls setup
lspconfig.gopls.setup {
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

----------------
-- Lua Configs
-- sumneko setup
USER = vim.fn.expand('$USER')

local sumneko_root_path = ""
local sumneko_binary = ""

if vim.fn.has("mac") == 1 then
  sumneko_root_path = "/Users/" .. USER .. "/.config/nvim/lua-language-server"
  sumneko_binary = "/Users/" .. USER .. "/.config/nvim/lua-language-server/bin/macOS/lua-language-server"
elseif vim.fn.has("unix") == 1 then
  sumneko_root_path = "/home/" .. USER .. "/.config/nvim/lua-language-server"
  sumneko_binary = "/home/" .. USER .. "/.config/nvim/lua-language-server/bin/Linux/lua-language-server"
else
  print("Unsupported OS for sumneko")
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup {
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      }
    }
  }
}
