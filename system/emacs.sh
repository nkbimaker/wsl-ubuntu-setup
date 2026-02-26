#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

# emacs-nox → emacs（GUI版）に切り替え
if dpkg -s emacs &>/dev/null && ! dpkg -s emacs-nox &>/dev/null; then
  log_skip "emacs (GUI version already installed)"
else
  if dpkg -s emacs-nox &>/dev/null; then
    log_info "Removing emacs-nox..."
    sudo apt remove -y emacs-nox
  fi
  log_info "Installing emacs (GUI version)..."
  sudo apt update
  sudo apt install -y emacs
fi

# Doom Emacs 依存パッケージ
DEPS=(pandoc shellcheck)
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
