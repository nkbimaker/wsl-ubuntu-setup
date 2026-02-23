#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

log_info() {
  echo -e "${GREEN}[INFO]${NC} $1"
}

log_skip() {
  echo -e "${YELLOW}[SKIP]${NC} $1 (already done)"
}

log_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

has_command() {
  command -v "$1" &>/dev/null
}

has_file() {
  [ -f "$1" ]
}

file_contains() {
  grep -qF "$1" "$2" 2>/dev/null
}
