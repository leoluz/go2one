{
  description = "Neovim, configured with this repo's config, packaged as a flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        # Tools the config's plugins shell out to (scripts/install.sh's verify_env
        # checks for most of these already; mason.nvim needs unzip/gzip/curl
        # to unpack the LSP servers it installs at runtime).
        runtimeDeps = with pkgs; [
          go
          gopls
          delve
          gcc
          gnumake
          git
          ripgrep
          fd
          fzf
          nodejs
          unzip
          gzip
          curl
        ];

        nvim = pkgs.symlinkJoin {
          name = "nvim";
          paths = [ pkgs.neovim-unwrapped ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/nvim \
              --prefix PATH : ${pkgs.lib.makeBinPath runtimeDeps}
          '';
        };
      in
      {
        packages.default = nvim;

        apps.default = {
          type = "app";
          program = "${nvim}/bin/nvim";
        };

        devShells.default = pkgs.mkShell {
          packages = runtimeDeps ++ [ pkgs.neovim ];
        };
      });
}
