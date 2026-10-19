# 🚀 Kurulum ve Dağıtım Kılavuzu (`install.md`)

Bu belge, **`pars-desktop-xfce`** meta paketinin nasıl derleneceğini, test edileceğini ve ParsLinux sistemlerine nasıl kurulacağını açıklamaktadır.

---

## 🛠️ Gereksinimler

- **Paketleme için:** `tar`, `ar` (binutils) veya `dpkg-buildpackage`
- **Sistem Kurulumu için:** Debian/Pardus/Pars tabanlı bir Linux dağıtımı (`dpkg` ve `apt`)

---

## 📦 1. Paketi Derleme (.deb Üretimi)

Proje kök dizininde bulunan `package.sh` betiğini çalıştırın:

```bash
./package.sh
```

Bu işlem `build/` dizini altında mimariden bağımsız `pars-desktop-xfce_1.0.0_all.deb` dosyasını üretir.

---

## 💻 2. Sisteme Kurulum

### Yöntem A: Kurulum Sihirbazı ile (Otomatik)
```bash
sudo ./install.sh
```

### Yöntem B: Manuel DPKG / APT ile
```bash
sudo dpkg -i build/pars-desktop-xfce_1.0.0_all.deb
sudo apt-get install -f
```

---

## 🔍 3. Sağlık Denetimi

Kurulum sonrası veya geliştirme aşamasında sistem bileşenlerinin ve bağımlılıkların durumunu denetlemek için:

```bash
./run.sh
```

---

## 🗑️ 4. Paketi Kaldırma

```bash
sudo ./uninstall.sh
# veya
sudo apt-get remove --purge pars-desktop-xfce
```
