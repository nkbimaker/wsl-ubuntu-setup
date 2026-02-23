#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

# Git PPA (最新版)
if grep -q "git-core/ppa" /etc/apt/sources.list.d/*.list 2>/dev/null; then
  log_skip "git PPA"
else
  log_info "Adding git PPA..."
  sudo add-apt-repository -y ppa:git-core/ppa
fi

PACKAGES=$(grep -v '^\s*#' "$SCRIPT_DIR/config/packages.txt" | grep -v '^\s*$')
TO_INSTALL=""

for pkg in $PACKAGES; do
  if dpkg -s "$pkg" &>/dev/null; then
    log_skip "$pkg"
  else
    TO_INSTALL="$TO_INSTALL $pkg"
  fi
done

if [ -n "$TO_INSTALL" ]; then
  log_info "Installing:$TO_INSTALL"
  sudo apt update
  sudo apt install -y $TO_INSTALL
else
  # PPA追加後、gitが古ければアップグレード
  sudo apt update
  sudo apt upgrade -y git
fi
