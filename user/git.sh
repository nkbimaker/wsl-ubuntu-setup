#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"
source "$SCRIPT_DIR/lib/env.sh"

CURRENT_NAME=$(git config --global user.name 2>/dev/null || echo "")
CURRENT_EMAIL=$(git config --global user.email 2>/dev/null || echo "")

if [ "$CURRENT_NAME" = "$GIT_NAME" ]; then
  log_skip "git user.name ($GIT_NAME)"
else
  log_info "Setting git user.name to $GIT_NAME..."
  git config --global user.name "$GIT_NAME"
fi

if [ "$CURRENT_EMAIL" = "$GIT_EMAIL" ]; then
  log_skip "git user.email ($GIT_EMAIL)"
else
  log_info "Setting git user.email to $GIT_EMAIL..."
  git config --global user.email "$GIT_EMAIL"
fi

# Default branch
CURRENT_BRANCH=$(git config --global init.defaultBranch 2>/dev/null || echo "")
if [ "$CURRENT_BRANCH" = "main" ]; then
  log_skip "git init.defaultBranch (main)"
else
  log_info "Setting git init.defaultBranch to main..."
  git config --global init.defaultBranch main
fi

# Editor
CURRENT_EDITOR=$(git config --global core.editor 2>/dev/null || echo "")
if [ "$CURRENT_EDITOR" = "vi" ]; then
  log_skip "git core.editor (vi)"
else
  log_info "Setting git core.editor to vi..."
  git config --global core.editor vi
fi
