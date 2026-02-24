#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

DEST="$HOME/.local/bin/lazygit"

if has_command lazygit; then
  log_skip "lazygit"
else
  log_info "Installing lazygit..."
  ARCH=$(uname -m)
  if [ "$ARCH" = "x86_64" ]; then
    LG_ARCH="x86_64"
  elif [ "$ARCH" = "aarch64" ]; then
    LG_ARCH="arm64"
  else
    log_error "Unsupported architecture: $ARCH"
    exit 1
  fi
  LG_VERSION=$(curl -sS https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep tag_name | cut -d '"' -f 4 | sed 's/^v//')
  curl -L "https://github.com/jesseduffield/lazygit/releases/download/v${LG_VERSION}/lazygit_${LG_VERSION}_Linux_${LG_ARCH}.tar.gz" | tar -xz -C "$HOME/.local/bin" lazygit
  chmod 755 "$DEST"
  log_info "lazygit installed to $DEST"
fi
