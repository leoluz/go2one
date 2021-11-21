#!/usr/bin/env bash
set -euo pipefail

GO2ONE_SCRIPT="https://raw.githubusercontent.com/leoluz/go2one/main/scripts/go2one.sh"
TARGET_BIN="/usr/local/bin/go2one"
sudo -- bash -c "curl -fsSL $GO2ONE_SCRIPT -o $TARGET_BIN; chmod +x $TARGET_BIN"
go2one install
