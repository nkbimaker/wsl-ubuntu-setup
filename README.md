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

| Module | 内容 | 再実行 |
|--------|------|--------|
| packages | apt パッケージ | ⏭️ スキップ |
| git | Git PPA（最新版）+ インストール | 🔄 最新化 |
| locale | タイムゾーン（Asia/Tokyo）・ロケール設定 | ⏭️ スキップ |
| wsl | wsl.conf の配置（systemd 有効化等） | ⏭️ スキップ |
| docker | Docker Engine + Compose | 🔄 最新化 |
| emacs | Emacs GUI + Doom 依存パッケージ | 🔄 最新化 |
| gh | GitHub CLI（PPA + インストール） | 🔄 最新化 |

### User

| Module | 内容 | 再実行 |
|--------|------|--------|
| zsh | デフォルトシェルを zsh に変更 | ⏭️ スキップ |
| ssh-agent | wsl2-ssh-agent（1Password SSH Agent 連携） | ⏭️ スキップ |
| mise | mise（ランタイムバージョン管理） | 🔄 最新化 |
| starship | Starship プロンプト | 🔄 最新化 |
| eza | eza（ls 代替） | ⏭️ スキップ |
| fzf | fzf（ファジーファインダー） | ⏭️ スキップ |
| gh | GitHub CLI 認証 | ⏭️ スキップ |
| gh-dash | gh-dash（GitHub ダッシュボード） | 🔄 最新化 |
| lazygit | lazygit（Git TUI） | ⏭️ スキップ |
| zellij | zellij（ターミナルマルチプレクサ） | ⏭️ スキップ |
| claude-code | Claude Code CLI | 🔄 最新化 |
| doom-emacs | Doom Emacs（クローン + インストール） | 🔄 最新化 |
| chezmoi | chezmoi + dotfiles の適用 | 🔄 最新化 |

### 手動アップデート

セットアップスクリプトでスキップされるモジュールを更新するには:

```bash
# apt 管理（packages, eza）
sudo apt update && sudo apt upgrade

# fzf / lazygit / zellij / ssh-agent
rm ~/.local/bin/{fzf,lazygit,zellij,wsl2-ssh-agent}
# → その後 setup を再実行
```

### apt パッケージ一覧

`config/packages.txt` で管理:

- build-essential, curl, wget, unzip
- ripgrep, fd-find, bat, cmake
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
│   ├── gh.sh               # GitHub CLI（PPA + インストール）
│   └── files/
│       └── wsl.conf
└── user/
    ├── zsh.sh              # zsh デフォルトシェル設定
    ├── ssh-agent.sh        # wsl2-ssh-agent
    ├── mise.sh             # mise
    ├── starship.sh         # Starship
    ├── eza.sh              # eza
    ├── fzf.sh              # fzf
    ├── gh.sh               # GitHub CLI 認証
    ├── gh-dash.sh          # gh-dash
    ├── lazygit.sh          # lazygit
    ├── zellij.sh           # zellij
    ├── claude-code.sh      # Claude Code
    ├── doom-emacs.sh       # Doom Emacs
    └── chezmoi.sh          # chezmoi + dotfiles
```
