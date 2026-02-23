#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

# Default shell
if [ "$SHELL" = "/usr/bin/zsh" ]; then
  log_skip "default shell is already zsh"
else
  log_info "Changing default shell to zsh..."
  chsh -s /usr/bin/zsh
fi
