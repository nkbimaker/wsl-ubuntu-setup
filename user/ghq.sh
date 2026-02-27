#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

DEST="$HOME/.local/bin/ghq"

if has_command ghq; then
  log_skip "ghq"
else
  log_info "Installing ghq..."
  ARCH=$(uname -m)
  if [ "$ARCH" = "x86_64" ]; then
    GHQ_ARCH="amd64"
  elif [ "$ARCH" = "aarch64" ]; then
    GHQ_ARCH="arm64"
  else
    log_error "Unsupported architecture: $ARCH"
    exit 1
  fi
  GHQ_VERSION=$(curl -sS https://api.github.com/repos/x-motemen/ghq/releases/latest | grep tag_name | cut -d '"' -f 4 | sed 's/^v//')
  TMPDIR=$(mktemp -d)
  curl -L "https://github.com/x-motemen/ghq/releases/download/v${GHQ_VERSION}/ghq_linux_${GHQ_ARCH}.zip" -o "$TMPDIR/ghq.zip"
  unzip -o "$TMPDIR/ghq.zip" -d "$TMPDIR"
  mv "$TMPDIR/ghq_linux_${GHQ_ARCH}/ghq" "$DEST"
  chmod 755 "$DEST"
  rm -rf "$TMPDIR"
  log_info "ghq installed to $DEST"
fi
