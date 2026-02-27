#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"
source "$SCRIPT_DIR/config/env.sh"

if has_command mise; then
  log_info "Upgrading mise..."
  mise self-update
else
  log_info "Installing mise..."
  curl https://mise.run | sh
fi

# mise で定義されたツール (go など) をインストール
log_info "Installing mise tools..."
mise install
