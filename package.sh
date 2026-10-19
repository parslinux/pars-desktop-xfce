#!/usr/bin/env bash
# ==============================================================================
# ParsLinux Desktop XFCE — Debian / Bağımsız Paketleme Betiği (package.sh)
# ==============================================================================
# Bu betik pars-desktop-xfce için Debian (.deb) paketi oluşturur.
# Hem Debian/Ubuntu üzerinde (dpkg-buildpackage) hem de bağımsız sistemlerde
# otomatik ikili paketleme mekanizmasıyla sorunsuz çalışır.
# ==============================================================================

set -e

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

PKG_NAME="pars-desktop-xfce"
VERSION="1.0.0"
ARCH="all"
OUTPUT_DIR="$SCRIPT_DIR/build"

echo -e "${CYAN}${BOLD}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║       📦 ParsLinux Desktop XFCE — Paketleme Motoru           ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

mkdir -p "$OUTPUT_DIR"

echo -e "${BOLD}Paket Adı    :${NC} ${CYAN}$PKG_NAME${NC}"
echo -e "${BOLD}Sürüm        :${NC} ${CYAN}$VERSION${NC}"
echo -e "${BOLD}Mimari       :${NC} ${CYAN}$ARCH${NC}\n"

# Yöntem 1: Sistemde dpkg-buildpackage varsa
if command -v dpkg-buildpackage &>/dev/null; then
    echo -e "${BOLD}[1/2] dpkg-buildpackage ile paket inşa ediliyor...${NC}"
    dpkg-buildpackage -us -uc -b
    mv ../${PKG_NAME}_* "$OUTPUT_DIR/" 2>/dev/null || true
    echo -e "\n${GREEN}✓ Paket başarıyla oluşturuldu: $OUTPUT_DIR/${NC}"
    ls -lh "$OUTPUT_DIR/"*.deb 2>/dev/null || true
    exit 0
fi

# Yöntem 2: Bağımsız Yerel İkili .deb Oluşturucu
echo -e "${YELLOW}ℹ️  dpkg-buildpackage bulunamadı, yerel ikili .deb paketleme adımları çalıştırılıyor...${NC}"

STAGE_DIR="$OUTPUT_DIR/stage"
rm -rf "$STAGE_DIR"
mkdir -p "$STAGE_DIR/DEBIAN"

echo -e "${BOLD}[1/4] Makefile ile yapılandırma dosyaları paket köküne yükleniyor...${NC}"
make install DESTDIR="$STAGE_DIR"

echo -e "${BOLD}[2/4] DEBIAN kontrol dosyaları yerleştiriliyor...${NC}"

cat << 'EOF' > "$STAGE_DIR/DEBIAN/control"
Package: pars-desktop-xfce
Version: 1.0.0
Section: metapackages
Priority: optional
Architecture: all
Maintainer: Pars Linux Developers <dev@parslinux.org>
Depends: pars-base, xfce4, xfce4-whiskermenu-plugin, lightdm, lightdm-gtk-greeter, thunar, xfce4-panel, xfce4-settings, xfce4-terminal, xfdesktop4, xfwm4
Recommends: pars-about | pardus-about, pars-update | pardus-update, parslinux-software | pardus-software | synaptic, pars-image-writer | pardus-image-writer, pars-mycomputer | pardus-mycomputer, parslinux-package-installer | pardus-package-installer, parslinux-formatter | pardus-usb-formatter, parslinux-boot-repair, atril | evince, catfish, engrampa | xarchiver | file-roller, galculator, menulibre, mousepad, network-manager-gnome, pavucontrol, ristretto, simple-scan, synaptic, tumbler, thunar-archive-plugin, thunar-volman, vlc | parole, xfce4-appfinder, xfce4-notifyd, xfce4-power-manager, xfce4-pulseaudio-plugin, xfce4-screenshooter, xfce4-taskmanager
Breaks: pardus-xfce-desktop
Conflicts: pardus-xfce-desktop
Replaces: pardus-xfce-desktop
Description: Pars Linux XFCE Lightweight Desktop Metapackage
 This metapackage provides the lightweight, high-performance XFCE desktop
 environment for Pars Linux.
 .
 It builds upon the core foundation (pars-base) and includes:
  * Full XFCE4 desktop suite (xfwm4, xfdesktop4, xfce4-panel, thunar)
  * Whisker Menu (xfce4-whiskermenu-plugin) for fast and modern application search
  * LightDM display manager with modern GTK greeter
  * Lightweight everyday utilities (Mousepad, Ristretto, Galculator, Atril/Evince)
  * Core Pars Linux ecosystem tools (Pars About, Update, Software, Image Writer,
    Formatter, Package Installer, Boot Repair)
EOF

echo -e "${BOLD}[3/4] İzinler düzenleniyor...${NC}"
find "$STAGE_DIR" -type d -exec chmod 755 {} +

echo -e "${BOLD}[4/4] .deb arşivi paketleniyor...${NC}"
DEB_FILE="$OUTPUT_DIR/${PKG_NAME}_${VERSION}_${ARCH}.deb"

if command -v dpkg-deb &>/dev/null; then
    dpkg-deb --build "$STAGE_DIR" "$DEB_FILE"
else
    # dpkg-deb yoksa standart ar + tar ile .deb oluştur
    (
        cd "$STAGE_DIR"
        echo "2.0" > debian-binary
        tar -czf "$OUTPUT_DIR/control.tar.gz" -C DEBIAN .
        tar --exclude=./DEBIAN --exclude=./debian-binary -czf "$OUTPUT_DIR/data.tar.gz" .
        cd "$OUTPUT_DIR"
        ar rcs "$DEB_FILE" "$STAGE_DIR/debian-binary" control.tar.gz data.tar.gz
        rm -f "$OUTPUT_DIR/control.tar.gz" "$OUTPUT_DIR/data.tar.gz"
    )
fi

rm -rf "$STAGE_DIR"

echo -e "\n${GREEN}${BOLD}══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}${BOLD}🎉 Debian paketi başarıyla üretildi!${NC}"
echo -e "${GREEN}${BOLD}══════════════════════════════════════════════════════════════${NC}"
echo -e "${BOLD}Paket Konumu:${NC} ${CYAN}$DEB_FILE${NC}"
ls -lh "$DEB_FILE"

echo -e "\n${BOLD}Kurulum için (Debian/Pars Linux):${NC}"
echo -e "  ${CYAN}sudo dpkg -i $DEB_FILE${NC}"
echo -e "  ${CYAN}sudo apt-get install -f${NC}\n"
