#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"
source "$SCRIPT_DIR/config/env.sh"

# fisher
if fish -c "type -q fisher" 2>/dev/null; then
  log_skip "fisher"
else
  log_info "Installing fisher..."
  fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
fi

# Default shell
if [ "$SHELL" = "/usr/bin/fish" ]; then
  log_skip "default shell is already fish"
else
  log_info "Changing default shell to fish..."
  chsh -s /usr/bin/fish
fi
