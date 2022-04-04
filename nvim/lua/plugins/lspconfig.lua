local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function()
  -- vim.api.nvim_set_keymap("n", "<Leader>o", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", {noremap = true, silent = true})
  -- vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", {noremap = true, silent = true})
  -- vim.api.nvim_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", {noremap = true, silent = true})
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

---------------
-- Go Configs
-- gopls setup
lspconfig.gopls.setup{
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

-- golangci-lint-langserver setup
-- if not configs.golangcilsp then
--   configs.golangcilsp = {
--     default_config = {
--       cmd = {"golangci-lint-langserver", "-debug", "true"},
--       root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
--       init_options = {
--         command = { "golangci-lint", "run", "--enable-all", "--disable", "lll", "--out-format", "json" };
--       }
--     };
--   }
-- end

-- lspconfig.golangcilsp.setup {
--   filetypes = {'go'}
-- }

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
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = runtime_path,
            },
            diagnostics = {
                globals = {'vim'}
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            }
        }
    }
}
