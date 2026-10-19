#!/usr/bin/env bash
# ==============================================================================
# ParsLinux Desktop XFCE — Sistem ve Bileşen Sağlık Denetimi (run.sh)
# ==============================================================================
# Bu betik pars-desktop-xfce meta paketinin ve bağımlı XFCE bileşenlerinin
# (XFCE4, Whisker Menu, LightDM, Hafif Araçlar, Pars Ekosistemi) durumunu denetler.
# ==============================================================================

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo -e "${CYAN}${BOLD}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║      🐆 ParsLinux Desktop XFCE — Bileşen Denetimi            ║"
echo "║      (XFCE4 + Whisker Menu + Hafif Araçlar + Pars Araçları)  ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# 1. Taban Katmanı (pars-base)
echo -e "${BOLD}[1/5] 🏗️ Temel Sistem Katmanı (pars-base):${NC}"
if dpkg -l pars-base &>/dev/null 2>&1; then
    echo -e "  • pars-base Paketi        : ${GREEN}✓ Kurulu${NC}"
elif [ -d "../pars-base" ]; then
    echo -e "  • pars-base Deposu        : ${GREEN}✓ Yan dizinde mevcut${NC}"
else
    echo -e "  • pars-base               : ${YELLOW}⚠️ Henüz kurulu değil${NC}"
fi

# 2. XFCE Masaüstü Çekirdeği
echo -e "\n${BOLD}[2/5] 🖥️ XFCE4 Masaüstü & Ekran Yöneticisi:${NC}"
if command -v xfce4-session &>/dev/null; then
    XFCE_VER=$(xfce4-session --version 2>/dev/null | head -n 1 || echo "Mevcut")
    echo -e "  • XFCE4 Oturumu           : ${GREEN}✓ Kurulu${NC} (${CYAN}${XFCE_VER}${NC})"
else
    echo -e "  • XFCE4 Oturumu           : ${YELLOW}⚠️ xfce4-session bulunamadı${NC}"
fi

if command -v xfwm4 &>/dev/null; then
    echo -e "  • xfwm4 (Pencere Yöneticisi): ${GREEN}✓ Kurulu${NC}"
else
    echo -e "  • xfwm4                   : ${YELLOW}⚠️ Bulunamadı${NC}"
fi

if command -v xfce4-panel &>/dev/null; then
    echo -e "  • xfce4-panel             : ${GREEN}✓ Kurulu${NC}"
else
    echo -e "  • xfce4-panel             : ${YELLOW}⚠️ Bulunamadı${NC}"
fi

if command -v thunar &>/dev/null; then
    echo -e "  • Thunar (Dosya Yöneticisi): ${GREEN}✓ Kurulu${NC}"
else
    echo -e "  • Thunar                  : ${YELLOW}⚠️ Bulunamadı${NC}"
fi

if systemctl list-unit-files lightdm.service &>/dev/null 2>&1 || [ -f "/etc/systemd/system/display-manager.service" ]; then
    echo -e "  • Display Manager         : ${GREEN}✓ LightDM / DM aktif${NC}"
else
    echo -e "  • Display Manager         : ${YELLOW}⚠️ LightDM servisi tespit edilemedi${NC}"
fi

# 3. Whisker Menu (Kritik Gereksinim)
echo -e "\n${BOLD}[3/5] 🔍 Whisker Menu Başlatıcı:${NC}"
if dpkg -l xfce4-whiskermenu-plugin &>/dev/null 2>&1 || [ -f "/usr/lib/x86_64-linux-gnu/xfce4/panel/plugins/libwhiskermenu.so" ] || [ -f "/usr/lib/xfce4/panel/plugins/libwhiskermenu.so" ]; then
    echo -e "  • Whisker Menu Eklentisi  : ${GREEN}✓ Kurulu${NC}"
else
    echo -e "  • Whisker Menu Eklentisi  : ${YELLOW}⚠️ xfce4-whiskermenu-plugin tespit edilemedi${NC}"
fi

# 4. Hafif Masaüstü Araçları
echo -e "\n${BOLD}[4/5] 🪶 Hafif Masaüstü Araçları:${NC}"
tools=(
    "mousepad:Metin Düzenleyici (Mousepad)"
    "ristretto:Görsel Görüntüleyici (Ristretto)"
    "galculator:Hesap Makinesi (Galculator)"
    "atril:Belge/PDF Görüntüleyici (Atril)"
    "evince:Belge/PDF Görüntüleyici (Evince)"
    "xarchiver:Arşiv Yöneticisi (Xarchiver)"
    "engrampa:Arşiv Yöneticisi (Engrampa)"
    "file-roller:Arşiv Yöneticisi (File Roller)"
    "catfish:Hızlı Dosya Arama (Catfish)"
    "synaptic:Paket Yöneticisi (Synaptic)"
    "pavucontrol:Ses Kontrol Paneli (PulseAudio/Pipewire)"
)

found_tools=0
for item in "${tools[@]}"; do
    bin="${item%%:*}"
    label="${item##*:}"
    if command -v "$bin" &>/dev/null; then
        echo -e "  • $label: ${GREEN}✓ Kurulu${NC}"
        ((found_tools++))
    fi
done

if [ "$found_tools" -eq 0 ]; then
    echo -e "  • Hafif Araçlar           : ${YELLOW}⚠️ Henüz sistemde kurulu değil (Kurulum için: apt install ...)${NC}"
fi

# 5. ParsLinux Ekosistem GUI Araçları
echo -e "\n${BOLD}[5/5] 🐆 ParsLinux Ekosistem Araçları:${NC}"
pars_apps=(
    "pars-about:Sistem Bilgisi (Pars About):../parslinux-about"
    "pars-update:Güncelleme Yöneticisi (Pars Update):../parslinux-Update"
    "parslinux-software:Yazılım Mağazası (Pars Software):../parslinux-software"
    "pars-image-writer:Kalıp Yazıcı (Pars Image Writer):../pars-image-writer"
    "pars-mycomputer:Bilgisayarım (Pars MyComputer):../parslinux-mycomputer"
    "parslinux-package-installer:Paket Kurucu (Pars Package Installer):../parslinux-package-installer"
    "parslinux-formatter:USB Formatlayıcı (Pars Formatter):../parslinux-formatter"
    "parslinux-boot-repair:Önyükleme Onarıcı (Pars Boot Repair):../parslinux-boot-repair"
)

for app in "${pars_apps[@]}"; do
    IFS=":" read -r cmd desc repo <<< "$app"
    if command -v "$cmd" &>/dev/null; then
        echo -e "  • $desc: ${GREEN}✓ Sistemde kurulu${NC}"
    elif [ -d "$repo" ]; then
        echo -e "  • $desc: ${GREEN}✓ Geliştirme dizininde mevcut${NC}"
    else
        echo -e "  • $desc: ${YELLOW}⚠️ Tespit edilemedi${NC}"
    fi
done

echo -e "\n${GREEN}${BOLD}══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}${BOLD}✓ ParsLinux Desktop XFCE durum denetimi tamamlandı.${NC}"
echo -e "${GREEN}${BOLD}══════════════════════════════════════════════════════════════${NC}\n"
