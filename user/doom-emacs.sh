#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

# fd シンボリックリンク（fd-find → fd）
if has_command fd; then
  log_skip "fd symlink"
else
  log_info "Creating fd symlink..."
  mkdir -p "$HOME/.local/bin"
  ln -s "$(which fdfind)" "$HOME/.local/bin/fd"
fi

# Doom Emacs クローン（XDG 準拠）
if [ -d "$HOME/.config/emacs" ]; then
  log_skip "Doom Emacs repository"
else
  if ! has_command emacs; then
    log_error "emacs is required but not installed"
    exit 1
  fi
  log_info "Cloning Doom Emacs..."
  git clone --depth 1 https://github.com/doomemacs/doomemacs "$HOME/.config/emacs"
fi

# doom install
if [ -f "$HOME/.local/share/doom/env" ]; then
  log_skip "doom install (already initialized)"
else
  log_info "Running doom install..."
  "$HOME/.config/emacs/bin/doom" install
fi
