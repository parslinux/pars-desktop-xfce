# 🐆 ParsLinux Desktop XFCE (`pars-desktop-xfce`)

ParsLinux işletim sistemi için ultra hafif, hızlı ve verimli **XFCE Masaüstü Ortamı Meta Paketi**.

Bu paket, temel sistem katmanı olan **`pars-base`** üzerine inşa edilerek XFCE4 masaüstü ortamını, **Whisker Menü** başlatıcısını, hafif günlük araçları ve özel Pars ekosistem uygulamalarını tek çatı altında toplar.

---

## 🏛️ Mimari Katman Yapısı

```
┌────────────────────────────────────────────────────────┐
│              📦 pars-desktop-xfce                      │
│   (XFCE4 + Whisker Menu + Hafif Araçlar + Pars GUI)    │
└──────────────────────────┬─────────────────────────────┘
                           │ Bağımlılık (Depends)
┌──────────────────────────▼─────────────────────────────┐
│                 📦 pars-base                           │
│  (Temel Kütüphaneler, PipeWire Ses, Yazı Tipleri, Ağ)   │
└──────────────────────────┬─────────────────────────────┘
                           │ Bağımlılık (Depends)
┌──────────────────────────▼─────────────────────────────┐
│               📦 pars-branding                         │
│  (Duvar Kağıtları, Simgeler, Fastfetch, Plymouth, Grub)│
└────────────────────────────────────────────────────────┘
```

---

## 📦 Paket İçeriği ve Bağımlılıklar

### 1. Çekirdek Bağımlılıklar (`Depends`)
* **`pars-base`**: ParsLinux temel sistem ve multimedya iskeleti
* **`xfce4`**: XFCE4 masaüstü ana bileşen paketi
* **`xfce4-whiskermenu-plugin`**: Hızlı arama ve modern kategori desteği sunan Whisker Menü
* **`lightdm` & `lightdm-gtk-greeter`**: Düşük kaynak tüketen modern oturum açma yöneticisi
* **`thunar`**: Hızlı ve hafif dosya yöneticisi
* **`xfwm4`**: XFCE pencere yöneticisi
* **`xfce4-panel`**: Çok işlevli ve özelleştirilebilir görev çubuğu
* **`xfdesktop4`**: Masaüstü simge ve arka plan yöneticisi
* **`xfce4-settings`**: Grafiksel sistem ayarları merkezi
* **`xfce4-terminal`**: Hızlı VTE tabanlı terminal

### 2. Hafif Günlük Araçlar (`Recommends`)
* **Metin Düzenleyici:** `mousepad`
* **Görsel Görüntüleyici:** `ristretto`
* **Hesap Makinesi:** `galculator`
* **Belge / PDF Görüntüleyici:** `atril` veya `evince`
* **Arşiv Yöneticisi:** `engrampa`, `xarchiver` veya `file-roller`
* **Dosya Arama:** `catfish`
* **Medya Oynatıcı:** `vlc` veya `parole`
* **Ses Kontrol Paneli:** `pavucontrol` & `xfce4-pulseaudio-plugin`
* **Güç Yönetimi:** `xfce4-power-manager`
* **Görev Yöneticisi:** `xfce4-taskmanager`
* **Ekran Görüntüsü:** `xfce4-screenshooter`

### 3. ParsLinux Entegre Araçları (`Recommends`)
* **Sistem Bilgisi:** `pars-about` | `pardus-about`
* **Güncelleme Yöneticisi:** `pars-update` | `pardus-update`
* **Yazılım Merkezi:** `parslinux-software` | `pardus-software` | `synaptic`
* **Kalıp Yazıcı:** `pars-image-writer` | `pardus-image-writer`
* **Bilgisayarım:** `pars-mycomputer` | `pardus-mycomputer`
* **Paket Kurucu:** `parslinux-package-installer` | `pardus-package-installer`
* **Disk Formatlayıcı:** `parslinux-formatter` | `pardus-usb-formatter`
* **Önyükleme Onarıcı:** `parslinux-boot-repair`

---

## 🚀 Hızlı Başlangıç

### 1. Paketleme (.deb oluşturma)
```bash
./package.sh
```
Çıktı `build/pars-desktop-xfce_1.0.0_all.deb` olarak üretilir.

### 2. Sistem Sağlık Denetimi
```bash
./run.sh
```

### 3. Sisteme Kurulum
```bash
sudo ./install.sh
# veya
sudo dpkg -i build/pars-desktop-xfce_1.0.0_all.deb
sudo apt-get install -f
```

### 4. Kaldırma
```bash
sudo ./uninstall.sh
```

---

## 🎨 XFCE Özel Yapılandırması (Xfconf)
Paket kurulduğunda sistem genelinde aşağıdaki varsayılanlar atanır:
* Panel sol alt köşesinde **Whisker Menü** ve **ParsLinux logosu**
* Varsayılan GTK Teması: **Pars-GTK-Theme**
* Varsayılan Simge Teması: **Pars_Icon_Theme_v1**
* Varsayılan Duvar Kağıdı: **`/usr/share/backgrounds/parslinux/pars-default.png`**

---

## 📄 Lisans
Bu proje GNU Genel Kamu Lisansı sürüm 3 (GPL-3.0) ile lisanslanmıştır.
