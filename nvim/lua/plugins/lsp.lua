return {
  {
    {
      -- manage LSP server installations
      'williamboman/mason.nvim',
      config = function()
        require("mason").setup()
      end
    },
    {
      -- configure Lua development
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          "LazyVim",
        },
      },
    },
    {
      -- provides lsp configurations
      "neovim/nvim-lspconfig",
      config = function()
        -- configs that are applied to all LSPs
        vim.lsp.config('*', {
          capabilities = {
            textDocument = {
              semanticTokens = {
                multilineTokenSupport = true,
              }
            }
          },
          root_markers = { '.git' },
        })

        -- configs available in https://github.com/neovim/nvim-lspconfig/tree/master/lsp
        -- Lua LSP Setup
        vim.lsp.enable('lua_ls')

        -- Go LSP Setup
        vim.lsp.enable('gopls')

        -- Bash LSP Setup
        vim.lsp.enable('bashls')

        --- YAML LSP Setup
        vim.lsp.config('yamlls', {
          settings = {
            yaml = {
              schemas = { kubernetes = "*.yaml" },
              format = {
                enable = true,
                singleQuote = true,
                formatOnType = true,
              },
            },
          },
        })
        vim.lsp.enable('yamlls')
      end
    },
  }
}
