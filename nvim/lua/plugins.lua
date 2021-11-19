require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  --dashboard
  use {
    "glepnir/dashboard-nvim",
    config = function()
      require("plugins/dashboard")
    end
  }

  -- nvim-tree
  use {
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugins/nvim-tree")
    end
  }

  -- fugitive
  use { "tpope/vim-fugitive" }

  -- themes
  use {
    "navarasu/onedark.nvim",
    config = function()
      require("plugins/onedark")
    end
  }
  use {
    "rakr/vim-one",
  }
  use {
    disable = true,
    "olimorris/onedarkpro.nvim",
    config = function()
      require("plugins/onedarkpro")
    end
  }

  -- vsnips
  use { "rafamadriz/friendly-snippets" }
  use { "hrsh7th/vim-vsnip", after = "nvim-cmp" }
  use { "hrsh7th/vim-vsnip-integ" }

  -- nvim-cmp
  use {
    "hrsh7th/nvim-cmp",
    --after = "nvim-lspconfig",
    config = function()
      require("plugins/cmp")
    end
  }
  use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }
  use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
  use { "hrsh7th/cmp-vsnip", after = "nvim-cmp" }

  -- lsp-config
  use {
    "neovim/nvim-lspconfig",
    after = "cmp-nvim-lsp",
    config = function()
      require("plugins/lspconfig")
    end
  }

  -- treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSInstallSync go",
    branch = "0.5-compat",
    config = function()
      require("plugins/treesitter")
    end
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
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
    after = "telescope.nvim",
    config = function()
      require("plugins/telescope-fzf-native")
    end
  }
  use {
    "gbrlsnchs/telescope-lsp-handlers.nvim",
    after = "telescope.nvim",
    config = function()
      require("plugins/telescope-lsp-handlers")
    end
  }
  use {
    "nvim-telescope/telescope.nvim",
    requires = { {"nvim-lua/plenary.nvim"} },
    config = function()
      require("plugins/telescope")
    end
  }

  -- lualine
  use {
    "nvim-lualine/lualine.nvim",
    requires = {"kyazdani42/nvim-web-devicons", opt = true},
    config = function()
      require("plugins/lualine")
    end
  }

  -- bufferline
  use {
    "akinsho/bufferline.nvim",
    requires = {"kyazdani42/nvim-web-devicons", opt = true},
    config = function()
      require("plugins/bufferline")
    end
  }

  -- gitsigns
  use {
    "lewis6991/gitsigns.nvim",
    requires = { {"nvim-lua/plenary.nvim"} },
    tag = "release", -- To use the latest release
    config = function()
      require("plugins/gitsigns")
    end
  }

  -- autopairs
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("plugins/nvim-autopairs")
    end
  }

  -- debug
  use {
    "mfussenegger/nvim-dap",
    config = function()
      require("plugins/nvim-dap")
    end
  }
  use {
    "rcarriga/nvim-dap-ui",
    after = "nvim-dap",
    config = function()
      require("plugins/nvim-dap-ui")
    end
  }

  -- go
  use {
    "leoluz/nvim-dap-go",
    config = function()
      require("plugins/nvim-dap-go")
    end
  }

  -- comment
  use {
    "numToStr/Comment.nvim",
    config = function()
      require("plugins/comment")
    end
  }

end)
