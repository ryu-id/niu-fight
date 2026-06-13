# PROMPT LENGKAP UNTUK HERMES AGENT
## Eksekusi Niu-Fight - Build APK untuk Infinix GT 30 Pro

---

## 📋 TUGAS UTAMA

Kamu adalah Hermes Agent. Tugasmu adalah:
1. Download dan setup environment yang dibutuhkan
2. Buka project Niu-Fight
3. Install semua dependency (Godot + Android Export Template)
4. Export project menjadi file APK yang siap install
5. Push ke GitHub repo dan buat Release baru

---

## 🔧 LANGKAH 1: PERSIAPAN LINGKUNGAN

### 1.1 Install Godot 4.3

```bash
# Download Godot 4.3 (Linux x86_64)
wget https://github.com/godotengine/godot/releases/download/4.3-stable/Godot_v4.3-stable_linux.x86_64.zip

# Extract
unzip Godot_v4.3-stable_linux.x86_64.zip

# Buat symlink agar mudah dipanggil
sudo ln -s $(pwd)/Godot_v4.3-stable_linux.x86_64 /usr/local/bin/godot

# Verifikasi
godot --version
```

### 1.2 Install Android Export Template

```bash
# Download Android export template
wget https://github.com/godotengine/godot/releases/download/4.3-stable/Godot_v4.3-stable_export_templates.tpz

# Extract ke folder Godot templates
mkdir -p ~/.local/share/godot/export_templates/4.3.stable
unzip Godot_v4.3-stable_export_templates.tpz -d ~/.local/share/godot/export_templates/4.3.stable/
```

### 1.3 Install Android SDK & Build Tools (Minimal)

```bash
# Install OpenJDK 17
sudo apt update
sudo apt install -y openjdk-17-jdk

# Install Android command line tools
wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
unzip commandlinetools-linux-11076708_latest.zip -d android-sdk
mkdir -p android-sdk/cmdline-tools/latest
mv android-sdk/cmdline-tools/bin android-sdk/cmdline-tools/latest/

# Setup environment
export ANDROID_HOME=$HOME/android-sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools

# Accept licenses dan install platform
yes | sdkmanager --licenses
sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"
```

---

## 📁 LANGKAH 2: SETUP PROJECT

### 2.1 Clone atau Download Project

```bash
# Jika belum ada folder niu-fight
git clone https://github.com/ryu-id/niu-fight.git
cd niu-fight
```

### 2.2 Verifikasi Struktur Project

Pastikan struktur berikut ada:

```
niu-fight/
├── project.godot
├── export_presets.cfg
├── scenes/
│   ├── main_menu.tscn
│   ├── character_select.tscn
│   ├── fight_arena.tscn
│   ├── story_mode.tscn
│   └── training.tscn
├── scripts/
│   ├── fighter_base.gd
│   ├── player.gd
│   ├── game_manager.gd
│   └── ...
├── assets/
│   ├── characters/
│   └── stages/
└── README.md
```

---

## 🚀 LANGKAH 3: EXPORT APK

### 3.1 Export Debug APK (untuk testing)

```bash
godot --headless --export-debug "Android" build/Niu-Fight-debug.apk
```

### 3.2 Export Release APK (untuk distribusi)

```bash
godot --headless --export-release "Android" build/Niu-Fight-release.apk
```

### 3.3 Verifikasi Hasil

```bash
ls -lh build/*.apk
```

---

## 📤 LANGKAH 4: PUSH KE GITHUB & BUAT RELEASE

### 4.1 Push Perubahan (jika ada)

```bash
git add .
git commit -m "Build: Niu-Fight v1.0.0 - Ready APK"
git push origin master
```

### 4.2 Buat GitHub Release

```bash
# Install GitHub CLI jika belum ada
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

# Login ke GitHub
gh auth login

# Buat Release baru
gh release create v1.0.0 \
  --title "Niu-Fight v1.0.0 - Release" \
  --notes "Niu-Fight - Fighting Game bertema Kerajaan Nusantara

## Fitur
- 4 Karakter: Gajah Mada, Naga Samudra, Garuda Singhasari, Keris Emas
- 3 Mode: Arcade, Story, Training
- 4 Stage bersejarah
- Touch controls + GT Triggers support
- Optimasi untuk Infinix GT 30 Pro

## Cara Install
1. Download Niu-Fight-release.apk
2. Install di HP (aktifkan Unknown Sources)
3. Main game

Target: Android 15 (API 34)
Engine: Godot 4.3" \
  build/Niu-Fight-release.apk \
  build/Niu-Fight-debug.apk
```

---

## ✅ VERIFIKASI AKHIR

Setelah selesai, pastikan:

- [ ] File `Niu-Fight-release.apk` ada di folder `build/`
- [ ] Release baru muncul di GitHub
- [ ] APK bisa diinstall di Infinix GT 30 Pro
- [ ] Game berjalan tanpa error

---

## 📝 CATATAN PENTING

- Gunakan **Godot 4.3** (bukan versi lain)
- Pastikan Android Export Template sudah terinstall
- Target SDK = 34 (Android 14/15)
- Architecture: arm64 + arm32
- High Refresh Rate: Enabled

---

**Prompt ini harus dijalankan secara berurutan tanpa melewatkan langkah.**