#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"
source "$SCRIPT_DIR/lib/env.sh"

DEST="$HOME/.local/bin/zellij"

if has_command zellij; then
  log_skip "zellij"
else
  log_info "Installing zellij..."
  mkdir -p "$HOME/.local/bin"
  ARCH=$(uname -m)
  if [ "$ARCH" = "x86_64" ]; then
    curl -L https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz | tar -xz -C "$HOME/.local/bin"
  elif [ "$ARCH" = "aarch64" ]; then
    curl -L https://github.com/zellij-org/zellij/releases/latest/download/zellij-aarch64-unknown-linux-musl.tar.gz | tar -xz -C "$HOME/.local/bin"
  else
    log_error "Unsupported architecture: $ARCH"
    exit 1
  fi
  chmod 755 "$DEST"
  log_info "zellij installed to $DEST"
fi
