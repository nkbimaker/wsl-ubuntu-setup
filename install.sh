#!/bin/bash
set -eu

REPO="https://github.com/nkbimaker/wsl-ubuntu-setup.git"
DEST="$HOME/src/github.com/nkbimaker/wsl-ubuntu-setup"

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
  mkdir -p "$(dirname "$DEST")"
  git clone "$REPO" "$DEST"
fi

# ~/.local/bin に setup-wsl シンボリックリンクを作成
mkdir -p "$HOME/.local/bin"
ln -sf "$DEST/bin/setup" "$HOME/.local/bin/setup-wsl"
echo "Linked: ~/.local/bin/setup-wsl -> $DEST/bin/setup"

# メイン処理実行
bash "$DEST/bin/setup"
