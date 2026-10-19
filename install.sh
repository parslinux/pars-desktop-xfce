#!/usr/bin/env bash
# ==============================================================================
# ParsLinux Desktop XFCE — Kurulum Betiği (install.sh)
# ==============================================================================
# Bu betik pars-desktop-xfce meta paketini derler ve sisteme kurar.
# ==============================================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${CYAN}${BOLD}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║      🐆 ParsLinux Desktop XFCE — Kurulum Sihirbazı           ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# 1. Paketi derle
echo -e "${BOLD}[1/2] Meta paket derleniyor...${NC}"
./package.sh

DEB_FILE=$(ls build/pars-desktop-xfce_*.deb 2>/dev/null | head -n 1)

if [ -z "$DEB_FILE" ]; then
    echo -e "${RED}Hata: Paket dosyası oluşturulamadı!${NC}"
    exit 1
fi

# 2. Sisteme kur (Debian/Pardus/Pars tabanlı sistemlerde)
if command -v apt-get &>/dev/null || command -v dpkg &>/dev/null; then
    if [ "$EUID" -ne 0 ]; then
        echo -e "\n${YELLOW}ℹ️  Paket kurulumu için root ayrıcalığı gerekiyor. Sudo isteniyor...${NC}"
        sudo dpkg -i "$DEB_FILE" || sudo apt-get install -f -y
    else
        dpkg -i "$DEB_FILE" || apt-get install -f -y
    fi
    echo -e "\n${GREEN}${BOLD}✓ pars-desktop-xfce başarıyla kuruldu!${NC}"
else
    echo -e "\n${YELLOW}ℹ️  Debian tabanlı olmayan bir sistemdesiniz (apt/dpkg bulunamadı).${NC}"
    echo -e "Paket dosyanız hazırlandı: ${CYAN}$DEB_FILE${NC}"
fi
