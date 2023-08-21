local lsp = require('lsp-zero')
local map = require("utils").map
local builtin = require('telescope.builtin')
local cmp = require('cmp')
local luasnip = require("luasnip")

local lspbuf = vim.lsp.buf

lsp.preset('recommended')
lsp.ensure_installed({
  'gopls',
  'lua_ls',
  'bashls',
  'cmake',
  -- 'tsserver',
  -- 'eslint',
  -- 'lua_ls',
  -- 'gopls',
})

local kind_icons = {
  Text = "",
  Method = "",
  Function = "󰊕",
  Constructor = "",
  Field = "",
  Variable = "󰫧",
  Class = "",
  Interface = "",
  Module = "󰕳",
  Property = "",
  Unit = "󰚯",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

lsp.on_attach(function(client, bufnr)
  local opt = { buffer = bufnr, remap = false }
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
end)

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end, { "i", "s" }),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { "i", "s" }),
})

lsp.setup_nvim_cmp {
  mapping = cmp_mappings,
  completion = {
    keyword_length = 1,
  },
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
      return vim_item
    end
  },
}

lsp.set_preferences({
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = false,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = true,
  call_servers = 'local',
  sign_icons = {
    error = '',
    warn = '',
    hint = '',
    info = ''
  }
})


--------------
-- yamlls setup
lsp.configure('yamlls', {
  settings = {
    yaml = {
      schemas = { kubernetes = "globPattern" },
    },
  },
})

--------------
-- gopls setup
lsp.configure('gopls', {
  settings = {
    gopls = {
      usePlaceholders = true, --enables placeholders for function parameters or struct fields in completion responses
    },
  },
})

----------------
-- sumneko setup
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lsp.configure('lua_ls', {
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
})

lsp.setup()
