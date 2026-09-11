# Go2one

A personal Neovim configuration, focused on Go development, that lives in its own directory so it never touches your existing Vim/Neovim setup.

---

* [Goal](#goal)
* [Project structure](#project-structure)
* [Requirements](#requirements)
* [Installation](#installation)
  * [Native install](#native-install)
  * [Nix flake](#nix-flake)
  * [Home Manager](#home-manager)
* [Usage](#usage)
  * [Plugin manager](#plugin-manager)
  * [Key bindings](#key-bindings)

## Goal

This project provides a Neovim configuration for Go (and general) development with modern IDE features (LSP, Treesitter, DAP, fuzzy finding, AI assistance) with as close to zero configuration as possible, without overwriting whatever Vim/Neovim setup you already have.

## Project structure

```
go2one/
├── nvim/                     # the actual Neovim configuration (this is what gets loaded as ~/.config/nvim)
│   ├── init.lua              # entry point, just requires the modules below in order
│   ├── lua/
│   │   ├── lazy-nvim.lua     # bootstraps lazy.nvim and points it at lua/plugins
│   │   ├── settings.lua      # core `vim.opt` options
│   │   ├── mappings.lua      # global key mappings not tied to a specific plugin
│   │   ├── autocmd.lua       # autocommands (LSP on-attach mappings, per-filetype buffer options, etc.)
│   │   ├── configs.lua       # misc `vim.*` config (currently diagnostic signs/float)
│   │   ├── utils.lua         # small helpers (`map`, `reload`) shared across the config
│   │   ├── gh_reviews.lua    # `:GhReviewedPRs` - Telescope picker for GitHub PRs you've reviewed
│   │   └── plugins/          # one file per plugin (or closely related group of plugins), see below
│   ├── snippets/go.json      # custom Go snippets, wired in via nvim/package.json
│   └── package.json          # declares nvim/snippets as a "friendly-snippets"-style package
├── scripts/
│   └── install.sh            # symlinks nvim/ to ~/.config/nvim (the "native install" method)
├── flake.nix / flake.lock    # Nix flake exposing Neovim + all runtime tools this config needs
├── Dockerfile / Makefile     # legacy container-based sandbox, predates the current lazy.nvim setup
└── README.md
```

### `nvim/lua/plugins/`

Each file returns a [lazy.nvim](https://github.com/folke/lazy.nvim) plugin spec. Grouped by purpose:

| Area | Files | Notes |
| --- | --- | --- |
| LSP | `lsp.lua` | `mason.nvim` + `mason-tool-installer.nvim` install servers; `nvim-lspconfig` enables `lua_ls`, `gopls`, `bashls`, `ts_ls`, `yamlls`; `lazydev.nvim` for Lua dev |
| Completion / snippets | `completion.lua` | `blink.cmp` + `friendly-snippets` (plus the repo's own `nvim/snippets/go.json`) |
| Treesitter | `treesitter.lua` | parsers for lua, vim, go, bash, json, yaml, javascript, html |
| Fuzzy finding | `telescope.lua` | `telescope.nvim` + `fzf-native`, `telescope-github`, `telescope-repo`, `advanced-git-search`; also wires up `gh_reviews.lua` |
| Git | `fugitive.lua`, `gitsigns.lua`, `diffview.lua` | commit/push, hunk staging & blame, diff views |
| Debugging | `nvim-dap.lua` | `nvim-dap` + `nvim-dap-ui` + `nvim-dap-go` |
| Testing | `neotest.lua`, `testo.lua` | `neotest` + `neotest-golang` (via `gotestsum`), plus the author's own `testo.nvim` |
| AI | `ai.lua` | `claudecode.nvim` (Claude Code integration); `copilot.lua` (CopilotChat) is present but disabled (`enabled = false`) |
| UI | `alpha.lua`, `bufferline.lua`, `lualine.lua`, `nvim-tree.lua`, `themes.lua`, `dashboard.lua` (disabled), `web-devicons.lua` | `catppuccin` (macchiato) is the active colorscheme; other themes are declared but disabled |
| Editing QoL | `autopairs.lua`, `comment.lua`, `marks.lua`, `surround.lua`, `markdown-preview.lua` | |

## Requirements

- [Neovim][20] 0.11.0+
- [Go][15] SDK
- [gopls][17] - Go LSP server
- [delve][16] - Go debugger
- [git](https://git-scm.com/), `make`, `gcc`, Node.js/`npm` - needed to build some plugins and to let `mason.nvim` install the remaining LSP servers
- [fzf][18], [ripgrep][19], [fd][22] - used by Telescope
- [gh CLI](https://cli.github.com/) - only needed for the GitHub-related Telescope pickers (`telescope-github`, `advanced-git-search`, `:GhReviewedPRs`)

All of the above (except `gh`) can be provided via the [Nix flake](#nix-flake) instead of installing them yourself.

## Installation

Go2one installs as a standard Neovim config: `~/.config/nvim` ends up being (a symlink to) this repo's `nvim/` directory. There's no separate wrapper command or isolated data directory - if you already have a Neovim config, back it up first.

### Native install

Clone the repo and run the install script, which checks for the required tools and symlinks `nvim/` to `~/.config/nvim`:

```sh
git clone https://github.com/leoluz/go2one.git
./go2one/scripts/install.sh
```

If a config already exists at `~/.config/nvim`, the script asks for confirmation before replacing it. Back up anything you want to keep beforehand - the script does not do it for you.

To update later, just `git pull` inside the cloned repo - since `~/.config/nvim` is a symlink into it, the change takes effect immediately. To uninstall, remove the symlink (`rm ~/.config/nvim`) and restore your own config from backup if you made one.

### Nix flake

If you have Nix with flakes enabled, the flake exposes Neovim wrapped with every runtime dependency this config needs (Go, gopls, delve, ripgrep, fd, fzf, Node.js, etc.) on its `PATH` - you don't need to install those yourself.

The flake still expects the config itself at `~/.config/nvim` (e.g. via the native install above, or by symlinking `nvim/` there yourself), it does not bundle a separate config path.

```sh
# drop into a shell with Neovim + all runtime deps on PATH
nix develop

# or run the wrapped Neovim directly
nix run .
```

### Home Manager

If you manage your environment with [Home Manager](https://github.com/nix-community/home-manager), add this repo as a flake input and wire up its package and config directory declaratively - no `scripts/install.sh` or manual symlinking needed:

```nix
{
  inputs = {
    # ...
    go2one.url = "github:leoluz/go2one";
  };

  outputs = { home-manager, go2one, ... }: {
    homeConfigurations."<user>" = home-manager.lib.homeManagerConfiguration {
      # ...
      modules = [
        ({ pkgs, ... }: {
          home.packages = [ go2one.packages.${pkgs.system}.default ];
          xdg.configFile."nvim".source = "${go2one}/nvim";
        })
      ];
    };
  };
}
```

- `go2one.packages.${system}.default` is the same wrapped Neovim binary as `nix run` above - all runtime tools already on its `PATH`.
- `xdg.configFile."nvim".source` symlinks `~/.config/nvim` straight into this flake's `nvim/` directory in the Nix store, so the config stays read-only and pinned to whatever revision your flake input locks to - `home-manager switch` is both your install and update step.
- lazy.nvim still manages plugins under `~/.local/share/nvim` at runtime, so that directory stays writable even though the config itself doesn't.

This replaces the [native install](#native-install) entirely - don't also run `scripts/install.sh` if you go this route.

## Usage

### Plugin manager

Plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim), bootstrapped automatically on first launch (`nvim/lua/lazy-nvim.lua`). Use `:Lazy` to sync/update/inspect plugins.

### Key bindings

The leader key is `<Space>`. A selection of the most useful mappings (see the plugin files under `nvim/lua/plugins/` and `nvim/lua/mappings.lua`/`autocmd.lua` for the full list):

**Files / search (Telescope)**
- `<leader>ff` find files, `<leader>fg` live grep, `<leader>fh` help tags, `<leader>fk` keymaps, `<leader>fd` diagnostics, `<leader>b` buffers
- `<leader>q` toggle file tree (`nvim-tree`)

**LSP** (set on `LspAttach`)
- `K` hover, `gd` definition, `gD` declaration, `gt` type definition, `gr` references, `gi` implementations, `ga` code action, `<leader>rn` rename
- `<leader>o` document symbols, `<leader>fs` workspace symbols, `gn`/`gp` next/prev diagnostic

**Git**
- `<leader>gg` `:Git`, `<leader>gc` commit, `<leader>gp` push, `<leader>gh` open GitHub URL (`GBrowse`)
- `<leader>gl` commits, `<leader>gb` branches, `<leader>gs` status, `<leader>gd` current-buffer history
- `<leader>gr` PRs you've reviewed in the repo detected from cwd (also `:GhReviewedPRs [login]`, see `gh_reviews.lua`)
- `gh` + `j`/`k`/`p`/`b`/`d`/`u` gitsigns hunk navigate/preview/blame/diff/reset
- `<leader>do`/`<leader>dc` open/close diffview against `master`

**Testing**
- `<leader>t` run nearest test (`testo.nvim`)
- `<leader>t` + `a`/`f`/`s`/`t`/`l`/`o`/`r`/`p`/`c`/`S`/`d` - neotest attach/run file/run suite/run nearest/run last/summary/output/output panel/clear/stop/debug

**Debugging**
- `F7` toggle breakpoint, `F8` continue, `F9` step over, `F10` step into, `F11` step out
- `<leader>du` toggle DAP UI, `<leader>i` eval, `<leader>y` debug nearest Go test

**AI (Claude Code)**
- `<leader>cc` toggle, `<leader>cr`/`<leader>cC` resume/continue, `<leader>cm` select model
- `<leader>cb` add current buffer, `<leader>cs` send selection / add file from tree, `<leader>ca`/`<leader>cd` accept/deny diff

[15]: https://go.dev/ "go"
[16]: https://github.com/go-delve/delve "delve"
[17]: https://pkg.go.dev/golang.org/x/tools/gopls#readme-installation "gopls"
[18]: https://github.com/junegunn/fzf "fzf"
[19]: https://github.com/BurntSushi/ripgrep#installation "ripgrep"
[20]: https://neovim.io/ "neovim"
[22]: https://github.com/sharkdp/fd "fd"
