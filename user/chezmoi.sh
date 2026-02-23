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
if [ -d "$DOTFILES_DIR" ]; then
  log_info "Updating dotfiles..."
  git -C "$DOTFILES_DIR" pull
else
  log_info "Cloning dotfiles..."
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

log_info "Applying dotfiles..."
chezmoi init --apply --source "$DOTFILES_DIR"
