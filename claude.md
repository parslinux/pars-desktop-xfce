# 🐆 Pars Linux Desktop XFCE (`pars-desktop-xfce`) — Geliştirici Kılavuzu

Bu belge, **Pars Linux** işletim sisteminin ultra hafif ve yüksek performanslı masaüstü katmanı olan `pars-desktop-xfce` paketinin mimarisini, dosya düzenini ve geliştirme yönergelerini içerir.

---

## 🎯 Proje Misyonu & Mimari

`pars-desktop-xfce`, Pars Linux'un resmi **hafif masaüstü meta paketi**dir. Düşük sistem kaynağına sahip cihazlarda maksimum akıcılık ve modern bir kullanıcı deneyimi sunmayı hedefler.

### Temel Sorumluluk Alanları:
1. **Temel Katman Entegrasyonu:** Taban sistem kütüphaneleri, PipeWire ses sunucusu ve yazı tiplerini sağlayan `pars-base` paketine dayanır.
2. **XFCE4 Masaüstü Çekirdeği:** `xfce4`, `xfwm4`, `xfce4-panel`, `thunar` ve `lightdm` ekran yöneticisini entegre eder.
3. **Whisker Menü Entegrasyonu:** Hızlı uygulama araması, kategori filtreleme ve ParsLinux logolu özel başlatıcı düğmesi sunar (`xfce4-whiskermenu-plugin`).
4. **ParsLinux Özel XFCE Önayarları (`etc/xdg/xfce4/...`):**
   - **Masaüstü Teması:** `Pars-GTK-Theme`
   - **Simge Teması:** `Pars_Icon_Theme_v1`
   - **Panel Düzeni:** Sol altta Whisker Menü, görev çubuğu pencereleri, bildirim alanı, Pipewire ses kontrolü ve saat.
   - **Duvar Kağıdı:** `/usr/share/backgrounds/parslinux/pars-default.png`
5. **Hafif Masaüstü Araçları:** Mousepad, Ristretto, Galculator, Atril/Evince, Engrampa/Xarchiver, Catfish, VLC/Parole.
6. **Pars Ekosistem Araçları:**
   - **Sistem Bilgisi:** `pars-about`
   - **Güncelleme Yöneticisi:** `pars-update`
   - **Yazılım Merkezi:** `parslinux-software`
   - **Kalıp Yazıcı:** `pars-image-writer`
   - **Bilgisayarım:** `pars-mycomputer`
   - **Paket Kurucu:** `parslinux-package-installer`
   - **Formatlayıcı:** `parslinux-formatter`
   - **Önyükleme Onarıcı:** `parslinux-boot-repair`

---

## 📂 Dizin ve Dosya Yapısı

```
pars-desktop-xfce/
├── debian/                     # Debian paketleme metadata ve kuralları
│   ├── changelog               # Sürüm geçmişi (1.0.0)
│   ├── control                 # Paket bağımlılıkları (Depends, Recommends, Conflicts)
│   └── rules                   # debhelper yapılandırması
├── etc/                        # XFCE sistem varsayılanları (xfconf)
│   └── xdg/xfce4/xfconf/xfce-perchannel-xml/
│       ├── xsettings.xml       # Pars teması, simge paketi ve font ayarları
│       ├── xfce4-panel.xml     # Whisker Menü entegreli görev çubuğu paneli
│       ├── xfwm4.xml           # Pars temalı pencere yöneticisi
│       └── xfce4-desktop.xml   # ParsLinux varsayılan duvar kağıdı
├── build/                      # Üretilen .deb paketleri (gitignore içerisinde)
├── Makefile                    # Standart kurulum, kaldırma ve temizleme hedefleri
├── package.sh                  # Taşınabilir .deb paketi oluşturucu (dpkg-buildpackage veya ar+tar)
├── run.sh                      # Sistem bileşenleri ve bağımlılık sağlık denetimi
├── install.sh                  # Paketi derleyip sisteme kuran betik
├── uninstall.sh                # Paketi sistemden kaldıran temizleme aracı
├── LICENSE                     # GNU General Public License v3.0 (GPL-3.0)
├── README.md                   # Proje tanıtım ve mimari dokümantasyonu
├── progress.md                 # Geliştirme ilerleme raporu ve kontrol listesi
├── install.md                  # Kurulum ve dağıtım kılavuzu
├── docs/                       # Ek dokümantasyon dizini
├── claude.md                   # AI asistan ve geliştirici el kitabı
├── .claudeignore               # Yapay zeka tarama hariç tutma listesi
└── .gitignore                  # Git hariç tutma kuralları
```

---

## 🛠️ Temel Komutlar

- **Paketleme:** `./package.sh`
- **Bileşen Denetimi:** `./run.sh`
- **Sisteme Kurulum:** `sudo ./install.sh`
- **Sistemden Kaldırma:** `sudo ./uninstall.sh`
- **Temizlik:** `make clean`
