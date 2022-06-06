# Go2one

A text editor for developers of the 21st century.

---

* [Goal](#goal)
* [Motivation](#motivation)
* [Features](#features)
* [Installation](#installation)
    * [Native install](#native-install)
    * [Container based](#container-based)
* [Upgrading](#upgrading)

## Goal

This project aims to provide a non intrusive Neovim configuration for Go development. The idea is that you can easily use this setup not having to touch your current Vim/Neovim configuration files.

## Motivation

Go2one was created for someone who:

* wants to quickly try running Neovim with IDE features with modern technologies ([LSP][1], [Treesitter][2], [DAP][3], etc) with zero configuration required.
* is curious about Neovim new features but wants to keep their current Vim/Neovim configuration files untouched.
* is curious about one specific plugin and wants to see it in action before spending time configuring it.

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

### Native install

Will use your current Neovim installation with isolated configuration files. This won't affect your existing Vim/Neovim setup.

This method will create two entries in your filesystem:
* `/usr/local/bin/go2one`: This a bash script that will be responsible to manage `go2one` configuration files and starting Neovim in a sandbox. 
* `$HOME/.config/go2one`: This is the folder where all configuration and plugin files will be created.

**Pre-reqs**

- [Neovim][20]: 0.5.1 
- [Go][15]: SDK for Go
- [delve][16]: for debugging Go projects
- [gopls][17]: LSP server for Go
- [fzf][18]: Fuzzy search of filesystem
- [ripgrep][19]: Live grep project file
- [fd][22]: Quickly find repos in the filesystem

To install `go2one` just run the command bellow:

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/leoluz/go2one/main/scripts/install.sh)"

Once the installation is concluded just run the `go2one` command to start the sandboxed Neovim.

See `go2one -h` for additional commands about how to update or uninstall `go2one`.

### Container based

Using this method, nothing will be installed in your computer. Neovim will run in a docker container with all dependencies installed and ready to use. The only requirement in this case is having Docker installed.

*Note*: Keep in mind that on MacOS or Windows, this method is going to have a lower filesystem performance if compared with the native installation. See this [github issue][21] for updates regarding this problem.

**Pre-reqs**
- Docker

Just run the following command in the folder having the files you want to edit:

    docker run --rm -it -v$(PWD):/home/nvim/work leoluz/go2one:latest

## Upgrading

### nvim-0.7.0

Seems some previously Treesitter parsers are incompatible with 0.7.0 and the following error might show up:
```
treesitter/highlighter: Error executing lua: /usr/share/nvim/runtime/lua/vim/treesitter/query.lua...
```
If this is the case run the following commands:
```
rm $HOME/.config/go2one/data/nvim/site/pack/packer/start/nvim-treesitter/parser/*
```
Then start nvim and run:
```
TSInstall all
```

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
[21]: https://github.com/docker/for-mac/issues/1592 "docker io issues"
[22]: https://github.com/sharkdp/fd "fd"
