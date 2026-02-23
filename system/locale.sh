#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SCRIPT_DIR/lib/utils.sh"

# Timezone
CURRENT_TZ=$(timedatectl show --property=Timezone --value 2>/dev/null || echo "")
if [ "$CURRENT_TZ" = "Asia/Tokyo" ]; then
  log_skip "timezone (Asia/Tokyo)"
else
  log_info "Setting timezone to Asia/Tokyo..."
  sudo timedatectl set-timezone Asia/Tokyo
fi

# Locales
LOCALES=(
  "en_US.UTF-8 UTF-8"
  "ja_JP.EUC-JP EUC-JP"
  "ja_JP.UTF-8 UTF-8"
)

LOCALE_CHANGED=false
for loc in "${LOCALES[@]}"; do
  if file_contains "$loc" /etc/locale.gen && ! grep -q "^# *$loc" /etc/locale.gen; then
    log_skip "locale ($loc)"
  else
    log_info "Enabling locale: $loc"
    sudo sed -i "s/^# *\($loc\)/\1/" /etc/locale.gen
    LOCALE_CHANGED=true
  fi
done

if [ "$LOCALE_CHANGED" = true ]; then
  log_info "Generating locales..."
  sudo locale-gen
fi

# Default locale
if locale 2>/dev/null | grep -q "LANG=en_US.UTF-8"; then
  log_skip "default locale (en_US.UTF-8)"
else
  log_info "Setting default locale to en_US.UTF-8..."
  sudo update-locale LANG=en_US.UTF-8
fi
