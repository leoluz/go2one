#!/usr/bin/env bash
set -euo pipefail

curl https://raw.githubusercontent.com/leoluz/go2one/main/scripts/go2one.sh -o /usr/local/bin/go2one
chmod +x /usr/local/bin/go2one
go2one install
