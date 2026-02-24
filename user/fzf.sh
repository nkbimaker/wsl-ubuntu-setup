#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

DEST="$HOME/.local/bin/fzf"

if has_command fzf; then
  log_skip "fzf"
else
  log_info "Installing fzf..."
  ARCH=$(uname -m)
  if [ "$ARCH" = "x86_64" ]; then
    FZF_ARCH="amd64"
  elif [ "$ARCH" = "aarch64" ]; then
    FZF_ARCH="arm64"
  else
    log_error "Unsupported architecture: $ARCH"
    exit 1
  fi
  FZF_VERSION=$(curl -sS https://api.github.com/repos/junegunn/fzf/releases/latest | grep tag_name | cut -d '"' -f 4 | sed 's/^v//')
  curl -L "https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-linux_${FZF_ARCH}.tar.gz" | tar -xz -C "$HOME/.local/bin"
  chmod 755 "$DEST"
  log_info "fzf installed to $DEST"
fi
