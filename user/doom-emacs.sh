#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

# Symbols Nerd Font Mono（Doom Emacs アイコン用）
FONT_DIR="$HOME/.local/share/fonts"
FONT_FILE="$FONT_DIR/SymbolsNerdFontMono-Regular.ttf"
if has_file "$FONT_FILE"; then
  log_skip "Symbols Nerd Font Mono"
else
  log_info "Installing Symbols Nerd Font Mono..."
  mkdir -p "$FONT_DIR"
  curl -fLo "$FONT_FILE" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/NerdFontsSymbolsOnly/SymbolsNerdFontMono-Regular.ttf
  fc-cache -fv
fi

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
  log_info "Upgrading Doom Emacs..."
  "$HOME/.config/emacs/bin/doom" upgrade
else
  log_info "Running doom install..."
  "$HOME/.config/emacs/bin/doom" install --env
fi

# ヘルスチェック
log_info "Running doom doctor..."
"$HOME/.config/emacs/bin/doom" doctor
