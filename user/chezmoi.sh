#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"
source "$SCRIPT_DIR/config/env.sh"

# chezmoi
if has_command chezmoi; then
  log_info "Upgrading chezmoi..."
  chezmoi upgrade
else
  log_info "Installing chezmoi..."
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
fi

# dotfiles
if [ -d "$HOME/.local/share/chezmoi" ]; then
  log_info "Updating dotfiles..."
  chezmoi init --apply
else
  log_info "Initializing dotfiles..."
  chezmoi init --apply "$DOTFILES_REPO"
fi
