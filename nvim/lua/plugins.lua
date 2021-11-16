require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  use {
    "scrooloose/nerdtree",
    opt = true,
    cmd = {"NERDTreeToggle"},
    config = function()
     require("plugins/nerdtree")
    end
  }

  -- Theme
  use {
    "navarasu/onedark.nvim",
    config = function()
      require("plugins/onedark")
    end
  }

  use {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins/lspconfig")
    end
  }

  -- TreeSitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSInstallSync go",
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

end)
