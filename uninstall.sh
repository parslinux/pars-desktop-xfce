#!/usr/bin/env bash
# ==============================================================================
# ParsLinux Desktop XFCE — Kaldırma Betiği (uninstall.sh)
# ==============================================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${RED}${BOLD}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║      🗑️ ParsLinux Desktop XFCE — Kaldırma Sihirbazı          ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

if command -v apt-get &>/dev/null; then
    if [ "$EUID" -ne 0 ]; then
        echo -e "${YELLOW}ℹ️  Paket kaldırma için root ayrıcalığı gerekiyor. Sudo isteniyor...${NC}"
        sudo apt-get remove --purge -y pars-desktop-xfce
    else
        apt-get remove --purge -y pars-desktop-xfce
    fi
    echo -e "\n${GREEN}✓ pars-desktop-xfce başarıyla kaldırıldı.${NC}"
else
    echo -e "${YELLOW}ℹ️  apt-get bulunamadı.${NC}"
fi
