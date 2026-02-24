#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

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
fi
