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
      -- auto-install configured mason packages
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      dependencies = { 'williamboman/mason.nvim' },
      config = function()
        require('mason-tool-installer').setup({
          ensure_installed = {
            'lua-language-server',
            'gopls',
            'bash-language-server',
            'yaml-language-server',
            'typescript-language-server',
          },
        })
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

        -- TypeScript / JavaScript LSP Setup
        -- mason package: typescript-language-server  (:MasonInstall typescript-language-server)
        vim.lsp.enable('ts_ls')

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
