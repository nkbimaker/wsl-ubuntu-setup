#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

# Docker apt リポジトリ
if [ -f /etc/apt/sources.list.d/docker.list ]; then
  log_skip "Docker repository"
else
  log_info "Adding Docker repository..."
  sudo apt install -y ca-certificates curl gnupg
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
fi

# Docker インストール / アップグレード
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# ユーザーを docker グループに追加
if id -nG "$USER" | grep -qw docker; then
  log_skip "docker group membership"
else
  log_info "Adding $USER to docker group..."
  sudo usermod -aG docker "$USER"
  log_info "Added $USER to docker group (effective after re-login)"
fi

# systemd で Docker を有効化
if systemctl is-enabled docker &>/dev/null; then
  log_skip "Docker service (enabled)"
else
  log_info "Enabling Docker service..."
  sudo systemctl enable docker
  sudo systemctl start docker
fi
