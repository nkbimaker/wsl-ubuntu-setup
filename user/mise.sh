#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"
source "$SCRIPT_DIR/lib/env.sh"

if has_command mise; then
  log_skip "mise"
else
  log_info "Installing mise..."
  curl https://mise.run | sh
fi
