#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"
source "$SCRIPT_DIR/config/env.sh"

if has_command claude; then
  log_info "Upgrading claude-code..."
  claude update
else
  log_info "Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | bash
fi
