local packer = require("packer")
-- packer.init{
--   max_jobs = 3,
-- }
packer.startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  --dashboard
  use {
    "glepnir/dashboard-nvim",
    commit = "a36b3232c98616149784f2ca2654e77caea7a522",
    config = function() require("plugins/dashboard") end,
  }

  -- nvim-tree
  use {
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
    config = function() require("plugins/nvim-tree") end,
  }

  -- fugitive
  use { "tpope/vim-fugitive",
    config = function() require("plugins/fugitive") end,
  }

  -- themes
  use {
    disable = true,
    "EdenEast/nightfox.nvim",
    config = function() require("plugins/nightfox") end,
  }
  use {
    disable = true,
    "folke/tokyonight.nvim",
    config = function()
      vim.g.tokyonight_style = "night"
      vim.g.tokyonight_transparent = true
    end,
  }
  use {
    disable = true,
    "navarasu/onedark.nvim",
    config = function() require("plugins/onedark") end,
  }
  use {
    disable = true,
    "rakr/vim-one",
  }
  use {
    disable = true,
    "olimorris/onedarkpro.nvim",
    config = function() require("plugins/onedarkpro") end,
  }
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function() require("plugins/catppuccin") end,
  }

  -- vsnips
  use {
    "hrsh7th/vim-vsnip",
    after = "nvim-cmp",
    config = function()
      vim.g.vsnip_snippet_dir = vim.env.XDG_CONFIG_HOME.."/nvim/snippets"
    end,
  }
  use { "hrsh7th/vim-vsnip-integ" }
  use { "rafamadriz/friendly-snippets" }

  -- nvim-cmp
  use {
    "hrsh7th/nvim-cmp",
    --after = "nvim-lspconfig",
    config = function() require("plugins/cmp") end,
  }
  use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }
  use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
  use { "hrsh7th/cmp-vsnip", after = "nvim-cmp" }

  -- lsp-config
  use {
    "neovim/nvim-lspconfig",
    after = {"cmp-nvim-lsp"},
    config = function() require("plugins/lspconfig") end,
  }

  -- treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSInstallSync go",
    -- branch = "0.5-compat",
    config = function() require("plugins/treesitter") end,
  }
  use {
    "nvim-treesitter/playground",
    after = "nvim-treesitter"
  }
  use {
    "nvim-treesitter/nvim-treesitter-refactor",
    after = "nvim-treesitter"
  }

  -- telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      {"nvim-lua/plenary.nvim"},
      {"gbrlsnchs/telescope-lsp-handlers.nvim"},
      {"nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
      },
      {"nvim-telescope/telescope-github.nvim"},
      {"cljoly/telescope-repo.nvim"},
    },
    config = function() require("plugins/telescope") end,
  }

  -- rooter
  use {
    "airblade/vim-rooter"
  }

  -- lualine
  use {
    "nvim-lualine/lualine.nvim",
    requires = {"kyazdani42/nvim-web-devicons", opt = true},
    config = function() require("plugins/lualine") end,
  }

  -- bufferline
  use {
    "akinsho/bufferline.nvim",
    tag = "v2.*",
    requires = {"kyazdani42/nvim-web-devicons", opt = true},
    config = function() require("plugins/bufferline") end,
  }

  -- gitsigns
  use {
    "lewis6991/gitsigns.nvim",
    config = function() require("plugins/gitsigns") end,
  }

  -- autopairs
  use {
    "windwp/nvim-autopairs",
    config = function() require("plugins/nvim-autopairs") end,
  }

  -- vim-surround
  use {
    "tpope/vim-surround",
    "tpope/vim-repeat",
  }

  -- debug
  use {
    "mfussenegger/nvim-dap",
    config = function() require("plugins/nvim-dap") end,
  }
  use {
    "rcarriga/nvim-dap-ui",
    after = "nvim-dap",
    config = function() require("plugins/nvim-dap-ui") end,
  }

  -- go
  use {
    "leoluz/nvim-dap-go",
    config = function() require("plugins/nvim-dap-go") end,
  }

  -- comment
  use {
    "numToStr/Comment.nvim",
    config = function() require("plugins/comment") end,
  }

  -- marks
  use {
    "chentoast/marks.nvim",
    config = function() require("plugins/marks") end,
  }

  -- vim-pencil
  -- use {
  --   "preservim/vim-pencil",
  --   config = function() require("plugins/pencil") end,
  -- }

end)
