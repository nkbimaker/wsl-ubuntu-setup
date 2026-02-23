#!/bin/bash
set -eu
mkdir -p $HOME/src

REPO="https://github.com/nkbimaker/wsl-ubuntu-setup.git"
DEST="$HOME/src/wsl-ubuntu-setup"

echo "=== WSL Ubuntu Setup ==="

# git がなければ最低限入れる
if ! command -v git &>/dev/null; then
  echo "Installing git..."
  sudo apt update && sudo apt install -y git
fi

# クローン or 更新
if [ -d "$DEST" ]; then
  echo "Updating wsl-ubuntu-setup..."
  git -C "$DEST" pull
else
  echo "Cloning wsl-ubuntu-setup..."
  git clone "$REPO" "$DEST"
fi

# メイン処理実行
bash "$DEST/setup.sh"
