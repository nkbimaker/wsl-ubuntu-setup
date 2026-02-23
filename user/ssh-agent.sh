#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"
source "$SCRIPT_DIR/config/env.sh"

DEST="$HOME/.local/bin/wsl2-ssh-agent"
ARCH=$(uname -m)

if has_file "$DEST"; then
  log_skip "wsl2-ssh-agent"
else
  log_info "Installing wsl2-ssh-agent..."
  mkdir -p "$HOME/.local/bin"
  if [ "$ARCH" = "x86_64" ]; then
    curl -L -o "$DEST" https://github.com/mame/wsl2-ssh-agent/releases/latest/download/wsl2-ssh-agent
  elif [ "$ARCH" = "aarch64" ]; then
    curl -L -o "$DEST" https://github.com/mame/wsl2-ssh-agent/releases/latest/download/wsl2-ssh-agent-arm64
  else
    log_error "Unsupported architecture: $ARCH"
    exit 1
  fi
  chmod 755 "$DEST"
  log_info "wsl2-ssh-agent installed to $DEST"
fi
