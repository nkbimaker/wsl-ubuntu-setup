#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

# 未認証なら認証を促す
if gh auth status &>/dev/null; then
  log_skip "gh auth (already authenticated)"
else
  log_info "gh auth login required. Starting authentication..."
  gh auth login
fi
