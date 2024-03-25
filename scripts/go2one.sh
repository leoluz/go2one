#!/usr/bin/env bash
set -euo pipefail

NVIM_HOME=$HOME/.config/nvim
NVIM_MIN_VERSION="v0.5.1"
GO2ONE_HOME=${GO2ONE_HOME:-$HOME/.config/go2one}
GO2ONE_BIN="/usr/local/bin/go2one"
DATA_HOME="$GO2ONE_HOME/data"
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

    if ! command -v go >/dev/null; then
        abort "Command 'go' not found"
    fi

    if ! command -v make >/dev/null; then
        abort "Command 'make' not found"
    fi

    if ! command -v gcc >/dev/null; then
        abort "Command 'gcc' not found"
    fi

    if ! command -v npm >/dev/null; then
	abort "Command 'npm' not found"
    fi

    nvim_version=$(nvim -version | head -n 1 | awk '{print $2}')
    if $( ! gte $nvim_version $NVIM_MIN_VERSION); then
        abort "Unsupported Neovim version ($nvim_version). Must be equal or greater than "$NVIM_MIN_VERSION
    fi
}

install() {
    mode=${2:-isolated}

    read -p "This will install go2one in mode '$mode'. Proceed? [Yy]" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "ok.. bye!"
        return 0
    fi

    verify_env
    if [ "$mode" == "native" ]; then
        native_install
    else 
        isolated_install
    fi
    return 0
}

isolated_install() {

    if [ ! -d "$GO2ONE_HOME" ]; then
        mkdir -p $GO2ONE_HOME
    fi
    if [ ! -d "$GO2ONE_HOME/go2one.git" ]; then
        git clone -q https://github.com/leoluz/go2one.git $GO2ONE_HOME/go2one.git
    fi
    if [ ! -d "$DATA_HOME" ]; then
        mkdir $DATA_HOME
    fi
    if [ ! -d "$PACKER_HOME" ]; then
        git clone -q --depth 1 https://github.com/wbthomason/packer.nvim $PACKER_HOME
    fi

    cmd="$NVIM_CMD --headless -c 'autocmd User PackerComplete quitall' +PackerSync"
    eval $cmd
    echo
}

native_install() {
    nvim_local_dir="$HOME/.local/share/nvim"
    if [[ -d "$NVIM_HOME" || -L "$NVIM_HOME" ]]; then
        echo "Existing nvim config found."
        echo "The file $NVIM_HOME will be deleted."
        echo "The folder $nvim_local_dir will be deleted."
        read -p "Proceed? [Yy]" -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "ok.. bye!"
            return 0
        fi
        rm -rf $NVIM_HOME
    fi
    if [[ -d "$nvim_local_dir" ]]; then
        rm -rf $nvim_local_dir
    fi

    script_dir=$(current_script_dir)
    repo_root_dir=$(dirname $script_dir)
    ln -s $repo_root_dir/nvim $HOME/.config/nvim
    echo "Installed. Have fun!"
}

current_script_dir() {
    SOURCE=${BASH_SOURCE[0]}
    while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
      DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
      SOURCE=$(readlink "$SOURCE")
      [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    echo $( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
}

reinstall() {
    if [ -d $GO2ONE_HOME ]; then
        rm -rf $GO2ONE_HOME
    fi
    install
    update_script
}

update_script() {
    if [ -f $GO2ONE_BIN ]; then
        rm $GO2ONE_BIN
    fi

    if [ ! -L $GO2ONE_BIN ]; then
        ln -s $GO2ONE_HOME/go2one.git/scripts/go2one.sh $GO2ONE_BIN
    fi
}

update() {
    if [ -d $GO2ONE_HOME/go2one.git ]; then
        GIT_DIR=$GO2ONE_HOME/go2one.git/.git git pull
    fi
    install
    update_script
}

uninstall() {
    if [ -d $GO2ONE_HOME ]; then
        rm -rf $GO2ONE_HOME
    fi
    if [ -f "/usr/local/bin/go2one" ]; then
        sudo rm /usr/local/bin/go2one
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

link() {
    if [ ! -L $NVIM_HOME ]; then
        ln -s $GO2ONE_HOME/go2one.git/nvim $NVIM_HOME
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
   echo "  install      install go2one under GO2ONE_HOME (default \$HOME/.config/go2one)."
   echo "  update       update go2one installation."
   echo "  reinstall    reinstall go2one. Data files will be deleted"
   echo "  uninstall    remove go2one installation"
   echo "  link         create nvim symlink"
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
        install $@
        ;;
    update)
        echo "Updating go2one..."
        update
        ;;
    reinstall)
        echo "Reinstalling go2one..."
        reinstall
        ;;
    uninstall)
        echo "Uninstalling go2one..."
        uninstall
        ;;
    link)
        echo "Creating nvim symlink"
        link
        ;;
    *)
        verify_install
        eval $NVIM_CMD $@
        ;;
esac
