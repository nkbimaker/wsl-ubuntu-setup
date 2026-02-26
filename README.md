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
- Windows 側で以下がセットアップ済みであること:
  - **1Password デスクトップアプリ** — SSH Agent 有効化 + CLI 連携有効化（Settings > Developer）
  - **1Password CLI** — `winget install AgileBits.1Password.CLI` でインストール
  - **フォント** — 以下を Windows 側にインストール:
    - [UDEV Gothic NF](https://github.com/yuru7/udev-gothic/releases) — ターミナル用日本語プログラミングフォント
    - [Symbols Nerd Font Mono](https://www.nerdfonts.com/font-downloads) — Doom Emacs アイコン表示用
    - [Symbola](https://symbl.cc/en/fonts/symbola/) — Emacs フォールバック用（絵文字・記号）

## インストールされるもの

### System（sudo 必要）

| Module | 内容 |
|--------|------|
| packages | apt パッケージ |
| git | Git PPA（最新版）+ インストール |
| locale | タイムゾーン（Asia/Tokyo）・ロケール設定 |
| wsl | wsl.conf の配置（systemd 有効化等） |
| docker | Docker Engine + Compose |
| emacs | Emacs GUI + Doom 依存パッケージ |

### User

| Module | 内容 |
|--------|------|
| zsh | デフォルトシェルを zsh に変更 |
| ssh-agent | wsl2-ssh-agent（1Password SSH Agent 連携） |
| mise | mise（ランタイムバージョン管理） |
| starship | Starship プロンプト |
| eza | eza（ls 代替） |
| fzf | fzf（ファジーファインダー） |
| gh | GitHub CLI + 認証 |
| gh-dash | gh-dash（GitHub ダッシュボード） |
| lazygit | lazygit（Git TUI） |
| zellij | zellij（ターミナルマルチプレクサ） |
| claude-code | Claude Code CLI |
| doom-emacs | Doom Emacs（クローン + インストール） |
| chezmoi | chezmoi + dotfiles の適用 |

### apt パッケージ一覧

`config/packages.txt` で管理:

- build-essential, curl, wget, unzip
- ripgrep, fd-find, bat, fzf
- zsh

## ディレクトリ構成
```
wsl-ubuntu-setup/
├── install.sh              # ワンライナー用エントリポイント
├── bin/
│   └── setup               # オーケストレーター
├── lib/
│   └── utils.sh            # ユーティリティ関数
├── config/
│   ├── env.sh              # 環境変数（PATH, Git設定等）
│   └── packages.txt        # apt パッケージ一覧
├── system/
│   ├── packages.sh         # apt パッケージ
│   ├── git.sh              # Git PPA + インストール
│   ├── locale.sh           # ロケール・タイムゾーン
│   ├── wsl.sh              # wsl.conf 配置
│   ├── docker.sh           # Docker Engine
│   ├── emacs.sh            # Emacs GUI + Doom 依存パッケージ
│   └── files/
│       └── wsl.conf
└── user/
    ├── zsh.sh              # zsh デフォルトシェル設定
    ├── ssh-agent.sh        # wsl2-ssh-agent
    ├── mise.sh             # mise
    ├── starship.sh         # Starship
    ├── eza.sh              # eza
    ├── fzf.sh              # fzf
    ├── gh.sh               # GitHub CLI
    ├── gh-dash.sh          # gh-dash
    ├── lazygit.sh          # lazygit
    ├── zellij.sh           # zellij
    ├── claude-code.sh      # Claude Code
    ├── doom-emacs.sh       # Doom Emacs
    └── chezmoi.sh          # chezmoi + dotfiles
```
