#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

if gh extension list 2>/dev/null | grep -q "dlvhdr/gh-dash"; then
  log_info "Upgrading gh-dash..."
  gh extension upgrade dlvhdr/gh-dash
else
  if ! has_command gh; then
    log_error "gh is required but not installed"
    exit 1
  fi
  log_info "Installing gh-dash..."
  gh extension install dlvhdr/gh-dash
  log_info "gh-dash installed"
fi
