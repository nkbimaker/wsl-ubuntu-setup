#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

# Docker Engine インストール
if has_command docker; then
  log_skip "Docker"
else
  log_info "Installing Docker..."

  # 依存パッケージ
  sudo apt update
  sudo apt install -y ca-certificates curl gnupg

  # Docker 公式 GPG キー
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg

  # apt リポジトリ追加
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  # インストール
  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  log_info "Docker installed successfully"
fi

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
