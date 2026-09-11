#!/usr/bin/env bash
set -euo pipefail

NVIM_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
NVIM_MIN_VERSION="v0.11.0"

abort() {
  printf "%s\n" "$@" >&2
  exit 1
}

# gte returns true if version $1 is greater than or equal to version $2.
gte() {
  local currentver requiredver
  currentver=$(echo "$1" | sed 's/^v//')
  requiredver=$(echo "$2" | sed 's/^v//')
  [ "$(printf '%s\n' "$requiredver" "$currentver" | sort -V | head -n1)" = "$requiredver" ]
}

verify_env() {
  for cmd in git nvim go make gcc npm; do
    if ! command -v "$cmd" >/dev/null; then
      abort "Command '$cmd' not found: it is required to install and run go2one."
    fi
  done

  nvim_version=$(nvim -version | head -n 1 | awk '{print $2}')
  if ! gte "$nvim_version" "$NVIM_MIN_VERSION"; then
    abort "Unsupported Neovim version ($nvim_version). Must be equal or greater than $NVIM_MIN_VERSION"
  fi
}

current_script_dir() {
  SOURCE=${BASH_SOURCE[0]}
  while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR=$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)
    SOURCE=$(readlink "$SOURCE")
    [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, resolve it relative to the symlink's location
  done
  echo $(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)
}

install() {
  verify_env

  script_dir=$(current_script_dir)
  repo_root_dir=$(dirname "$script_dir")

  if [[ -e "$NVIM_CONFIG_HOME" || -L "$NVIM_CONFIG_HOME" ]]; then
    echo "Found an existing Neovim config at $NVIM_CONFIG_HOME."
    echo "It will be replaced with a symlink to $repo_root_dir/nvim."
    echo "Back it up now if you want to keep it."
    read -p "Proceed? [Yy] " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      echo "ok.. bye!"
      return 0
    fi
    rm -rf "$NVIM_CONFIG_HOME"
  fi

  ln -s "$repo_root_dir/nvim" "$NVIM_CONFIG_HOME"
  echo "Installed. Run 'nvim' to get started."
}

install
