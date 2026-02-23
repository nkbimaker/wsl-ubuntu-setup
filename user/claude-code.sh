#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"
source "$SCRIPT_DIR/lib/env.sh"

if has_command claude; then
  log_skip "claude-code"
else
  log_info "Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | bash
fi
