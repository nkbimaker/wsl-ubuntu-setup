#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

# Emacs PPA (最新版)
if grep -q "ubuntuhandbook1/emacs" /etc/apt/sources.list.d/*.list 2>/dev/null; then
  log_skip "Emacs PPA"
else
  log_info "Adding Emacs PPA..."
  sudo add-apt-repository -y ppa:ubuntuhandbook1/emacs
fi

# Emacs インストール (terminal only)
if has_command emacs; then
  log_skip "Emacs"
else
  log_info "Installing Emacs (nox)..."
  sudo apt update
  sudo apt install -y emacs-nox
fi
