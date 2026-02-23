#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

WSL_CONF="/etc/wsl.conf"
SOURCE="$SCRIPT_DIR/system/files/wsl.conf"

if has_file "$WSL_CONF" && diff -q "$SOURCE" "$WSL_CONF" &>/dev/null; then
  log_skip "wsl.conf (unchanged)"
else
  log_info "Updating wsl.conf..."
  sudo cp "$SOURCE" "$WSL_CONF"
  log_info "wsl.conf updated. Run 'wsl --shutdown' from Windows to apply."
fi
