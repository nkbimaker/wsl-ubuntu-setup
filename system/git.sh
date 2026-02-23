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

# Git インストール / アップグレード
sudo apt update
sudo apt install -y git
