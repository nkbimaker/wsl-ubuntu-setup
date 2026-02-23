#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

# emacs-nox が残っていれば削除
if dpkg -s emacs-nox &>/dev/null; then
  log_info "Removing emacs-nox..."
  sudo apt remove -y emacs-nox
fi

# Emacs（GUI版）インストール / アップグレード
log_info "Installing/upgrading emacs..."
sudo apt update
sudo apt install -y emacs

# Doom Emacs 依存パッケージ
DEPS=(pandoc shellcheck fonts-symbola)
TO_INSTALL=""

for pkg in "${DEPS[@]}"; do
  if dpkg -s "$pkg" &>/dev/null; then
    log_skip "$pkg"
  else
    TO_INSTALL="$TO_INSTALL $pkg"
  fi
done

if [ -n "$TO_INSTALL" ]; then
  log_info "Installing Doom dependencies:$TO_INSTALL"
  sudo apt install -y $TO_INSTALL
fi
