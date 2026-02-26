#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

# APTリポジトリを追加（未登録の場合）
if [ ! -f /etc/apt/sources.list.d/github-cli.list ]; then
  log_info "Adding GitHub CLI apt repository..."
  sudo mkdir -p -m 755 /etc/apt/keyrings
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
  sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
fi

# 常に最新化
log_info "Installing/upgrading gh to latest..."
sudo apt update
sudo apt install -y gh
log_info "gh $(gh --version | head -1 | awk '{print $3}')"
