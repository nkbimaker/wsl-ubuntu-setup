#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

# 1Password CLI
if has_command op; then
  log_skip "op symlink"
else
  op_exe=$(compgen -G '/mnt/c/Users/*/AppData/Local/Microsoft/WinGet/Packages/AgileBits.1Password.CLI*/op.exe' | head -1)
  if [ -n "$op_exe" ]; then
    log_info "Creating op symlink..."
    mkdir -p "$HOME/.local/bin"
    ln -s "$op_exe" "$HOME/.local/bin/op"
  fi
fi
