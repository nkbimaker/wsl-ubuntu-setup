#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

DEST="$HOME/.local/bin/starship"

if has_command starship; then
  log_info "Upgrading starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir "$HOME/.local/bin" --yes
else
  log_info "Installing starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir "$HOME/.local/bin" --yes
  log_info "starship installed to $DEST"
fi
