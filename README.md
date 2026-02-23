# wsl-ubuntu-setup

WSL2 Ubuntu 環境をワンライナーでセットアップするスクリプト集。

## Quick Start
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nkbimaker/wsl-ubuntu-setup/main/install.sh)"
```

ローカルから直接実行する場合:
```bash
git clone git@github.com:nkbimaker/wsl-ubuntu-setup.git
cd wsl-ubuntu-setup
bash setup.sh
```

## 前提条件

- WSL2 + Ubuntu 24.04
- Windows 側で 1Password SSH Agent が有効化されていること

## インストールされるもの

### System（sudo 必要）

| Module | 内容 |
|--------|------|
| packages | apt パッケージ + Git PPA（最新版） |
| locale | タイムゾーン（Asia/Tokyo）・ロケール設定 |
| wsl | wsl.conf の配置（systemd 有効化等） |

### User

| Module | 内容 |
|--------|------|
| fish | fish shell + fisher（プラグインマネージャ） |
| ssh-agent | wsl2-ssh-agent（1Password SSH Agent 連携） |
| git | git グローバル設定（user, editor, defaultBranch） |
| mise | mise（ランタイムバージョン管理） |
| zellij | zellij（ターミナルマルチプレクサ） |
| claude-code | Claude Code CLI |
| chezmoi | chezmoi + dotfiles の適用 |

### apt パッケージ一覧

`config/packages.txt` で管理:

- build-essential, curl, wget, git, unzip
- ripgrep, fd-find, bat, fzf
- fish

## ディレクトリ構成
```
wsl-ubuntu-setup/
├── install.sh              # ワンライナー用エントリポイント
├── setup.sh                # オーケストレーター
├── lib/
│   ├── utils.sh            # ユーティリティ関数
│   └── env.sh              # 環境変数（PATH, Git設定等）
├── config/
│   └── packages.txt        # apt パッケージ一覧
├── system/
│   ├── packages.sh         # apt + Git PPA
│   ├── locale.sh           # ロケール・タイムゾーン
│   ├── wsl.sh              # wsl.conf 配置
│   └── files/
│       └── wsl.conf
└── user/
    ├── fish.sh             # fish + fisher
    ├── ssh-agent.sh        # wsl2-ssh-agent
    ├── git.sh              # git グローバル設定
    ├── mise.sh             # mise
    ├── zellij.sh           # zellij
    ├── claude-code.sh      # Claude Code
    └── chezmoi.sh          # chezmoi + dotfiles
```
