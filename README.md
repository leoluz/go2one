# Go2one

A text editor for developers of the 21st century.

## Goal

This project aims to provide a non intrusive Neovim configuration for Go development. The idea is that you can try this setup not having touch your current Vim/Neovim configuration files.

## Motivation

Go2one was created for someone who:

* is curious about the new features added in Neovim but for some reason want to keep their current configuration files untouched.
* is curious about one specific plugin and wants to see it in action before spending time configuring it in your setup.
* wants to try IDE features with modern technology ([LSP][1], [Treesitter][2], [DAP][3], etc) with zero configuration required.

## Features

* Quick docs, go to definition, go to implementation, find usage, diagnostics (native LSP)
* Git Integration ([gitsigns][4] + [fugitive][5])
* Cool tree-sitter based themes ([catppuccin][6], [onedark][7])
* Code snippets ([vim-vsnip][8])
* Auto completion ([nvim-cmp][9])
* Fuzzy find about everything ([telescope][10])
* Easy file context visualization ([lualine][11] + [bufferline][12])
* Debugging ([nvim-dap][13] + [nvim-dap-go][14])

and more..

## Installation

Go2one provides two different installation methods:

1. Container based: nothing is installed in your computer. You just need docker. Keep in mind that for larger code bases, this method is going to be much slower than native installation
1. Native installation: will use your current neovim with isolated configuration files. This won't affect your existing Vim/Neovim setup. This method will require a few tools to be preinstalled in your laptop. See the doc bellow for more details.

### Container

#### Pre-reqs

- Docker

#### How

Just run the following command in the folder having the files you want to edit:

    docker run --rm -it -v$(PWD):/home/nvim/work leoluz/go2one:latest

### Native


#### Pre-reqs

#### How

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/leoluz/go2one/main/scripts/install.sh)"

[1]: https://microsoft.github.io/language-server-protocol/ "Language Server Protocol"
[2]: https://tree-sitter.github.io/tree-sitter/ "Treesitter"
[3]: https://microsoft.github.io/debug-adapter-protocol/ "Debug Adapter Protocol"
[4]: https://github.com/lewis6991/gitsigns.nvim "gitsigns"
[5]: https://github.com/tpope/vim-fugitive "fugitive"
[6]: https://github.com/catppuccin/nvim "catppuccin"
[7]: https://github.com/navarasu/onedark.nvim "onedark"
[8]: https://github.com/hrsh7th/vim-vsnip "vsnip"
[9]: https://github.com/hrsh7th/nvim-cmp "nvim-cmp"
[10]: https://github.com/nvim-telescope/telescope.nvim "telescope"
[11]: https://github.com/nvim-lualine/lualine.nvim "lualine"
[12]: https://github.com/akinsho/bufferline.nvim "bufferline"
[13]: https://github.com/mfussenegger/nvim-dap "nvim-dap"
[14]: https://github.com/leoluz/nvim-dap-go "dap-go"
