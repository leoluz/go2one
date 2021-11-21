#!/usr/bin/env bash
set -euo pipefail

NVIM_MIN_VERSION="v0.5.1"
GO2ONE_HOME=${GO2ONE_HOME:-$HOME/.config/go2one}
DATA_HOME="$GO2ONE_HOME/data"
PACKER_HOME="$DATA_HOME/nvim/site/pack/packer/start/packer.nvim"
NVIM_CMD="XDG_CONFIG_HOME=$GO2ONE_HOME/go2one.git XDG_DATA_HOME=$DATA_HOME nvim"

abort() {
  printf "%s\n" "$@"
  exit 1
}

# gte greater-than-equal will validate the two version arguments passed and returns
# true if the first is greater or equal than the second. Will return false otherwise.
gte() {
    # Strip 'v' from version if it is the fist char
    currentver=$(echo "$1" | sed 's/^v//')
    requiredver=$(echo "$2" | sed 's/^v//')
    if [ "$(printf '%s\n' "$requiredver" "$currentver" | sort -V | head -n1)" = "$requiredver" ]; then 
        return 0
    else
        return 1
    fi
}

verify_env() {
    if ! command -v git >/dev/null; then
        abort "Command 'git' not found: Git must be installed"
    fi

    if ! command -v nvim >/dev/null; then
        abort "Command 'nvim' not found: Neovim must be installed"
    fi

    nvim_version=$(nvim -version | head -n 1 | awk '{print $2}')
    if $( ! gte $nvim_version $NVIM_MIN_VERSION); then
        abort "Unsupported Neovim version ($nvim_version). Must be equal or greater than "$NVIM_MIN_VERSION
    fi
}

install() {
    verify_env
    if [ ! -d "$GO2ONE_HOME" ]; then
        mkdir -p $GO2ONE_HOME
    fi
    if [ ! -d "$GO2ONE_HOME/go2one.git" ]; then
        git clone -q --depth 1 https://github.com/leoluz/go2one.git $GO2ONE_HOME/go2one.git
    fi
    if [ ! -d "$DATA_HOME" ]; then
        mkdir $DATA_HOME
    fi
    if [ ! -d "$PACKER_HOME" ]; then
        git clone -q --depth 1 https://github.com/wbthomason/packer.nvim $PACKER_HOME
    fi

    cmd="$NVIM_CMD --headless -c 'autocmd User PackerComplete quitall' +PackerSync"
    eval $cmd
}

reinstall() {
    if [ -d $GO2ONE_HOME ]; then
        rm -rf $GO2ONE_HOME
    fi
    install
}

uninstall() {
    if [ -d $GO2ONE_HOME ]; then
        rm -rf $GO2ONE_HOME
    fi
    if [ -f "/usr/local/bin/go2one" ]; then
        rm /usr/local/bin/go2one
    fi
}

verify_install() {
    if [ ! -d "$GO2ONE_HOME" ] ||
       [ ! -d "$GO2ONE_HOME/go2one.git" ] ||
       [ ! -d "$DATA_HOME" ] ||
       [ ! -d "$PACKER_HOME" ]; then
        abort "Go2one installation not found or corrupted. Please run 'go2one update' to fix it."
    fi
}

usage() {
   echo "Utility to run and manage go2one installation"
   echo
   echo " More info: https://github.com/leoluz/go2one"
   echo
   echo "Syntax: go2one [options] [command]"
   echo
   echo "To start neovim just run go2one with no command."
   echo
   echo "options:"
   echo "  -h           show this help."
   echo
   echo "commands:"
   echo "  install      install go2one under GO2ONE_HOME (default #HOME/.config/go2one)."
   echo "  update       update go2one installation."
   echo "  uninstall    remove go2one installation"
   echo
}

# -------------- Script ------------------ #

while getopts ":h" option; do
   case $option in
      h)
         usage
         exit;;
     \?)
         echo "Invalid option."
         echo "Usage:"
         echo
         usage
         exit;;
   esac
done

parm1=${1:-}
case $parm1 in
    install)
        echo "Installing go2one..."
        install
        ;;
    update)
        echo "Updating go2one..."
        reinstall
        ;;
    uninstall)
        echo "Uninstalling go2one..."
        uninstall
        ;;
    *)
        verify_install
        eval $NVIM_CMD
        ;;
esac
