# Go2one

A text editor for developers of the 21st century.

---

* [Goal](#goal)
* [Motivation](#motivation)
* [Features](#features)
* [Installation](#installation)
    * [Container based](#container-based)
    * [Native install](#native-install)

## Goal

This project aims to provide a non intrusive Neovim configuration for Go development. The idea is that you can try this setup not having to touch your current Vim/Neovim configuration files.

## Motivation

Go2one was created for someone who:

* is curious about Neovim new features but wants to keep their current configuration files untouched.
* is curious about one specific plugin and wants to see it in action before spending time configuring it.
* wants to quickly try running Neovim with IDE features with modern technologies ([LSP][1], [Treesitter][2], [DAP][3], etc) with zero configuration required.

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

### Container based

Nothing is installed in your computer. Keep in mind that this method is going to have much slower IO compared with the native installation.

**Pre-reqs**
- Docker

Just run the following command in the folder having the files you want to edit:

    docker run --rm -it -v$(PWD):/home/nvim/work leoluz/go2one:latest

### Native install

Will use your current Neovim installation with isolated configuration files. This won't affect your existing Vim/Neovim setup.
This method will install the script `go2one` in your path (`/usr/local/bin`). This script will be responsible to manage `go2one` configuration files and starting Neovim in a sandbox. All `go2one` related configuration files will be created in `$HOME/.config/go2one`. No other file will be created outside of this folder.

**Pre-reqs**

- [Neovim][20]: 0.5.1 
- [Go][15]: SDK for Go
- [delve][16]: for debugging Go projects
- [gopls][17]: LSP server for Go
- [fzf][18]: Fuzzy search of filesystem
- [ripgrep][19]: Live grep project file

To install `go2one` just run the command bellow:

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/leoluz/go2one/main/scripts/install.sh)"

Once the installation is concluded just run the `go2one` command to start the sandboxed Neovim.

See `go2one -h` for additional commands about how to update or uninstall `go2one`.

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
[15]: https://go.dev/ "go"
[16]: https://github.com/go-delve/delve "delve"
[17]: https://pkg.go.dev/golang.org/x/tools/gopls#readme-installation "gopls"
[18]: https://github.com/junegunn/fzf "fzf"
[19]: https://github.com/BurntSushi/ripgrep#installation "ripgrep"
[20]: https://neovim.io/ "neovim"
