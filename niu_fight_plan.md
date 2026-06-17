# RENCANA FINAL: Game Android "Niu-Fight"
## Target: Infinix GT 30 Pro (Perfect Optimization) - Single Player Focus

**Tanggal Update:** 2026-06-13 (Asia/Jakarta)
**Genre:** 2D Fighting Game (Arcade-style side-view fighter)
**Tema:** Kerajaan-kerajaan Nusantara pra-Indonesia
**Nama Game:** **Niu-Fight**
**Fokus:** Single Player Only (Arcade + Story Mode)
**Jumlah Karakter:** 4 Karakter (ringan & fokus)

---

## 1. ANALISIS DEVICE TARGET (Infinix GT 30 Pro)
- **Chipset:** MediaTek Dimensity 8350 Ultimate (4nm) + Mali-G615 MC6 GPU → Sangat kuat untuk 2D high-FPS (144Hz)
- **Display:** 6.78" 1.5K AMOLED 144Hz → Target 120 FPS smooth
- **RAM:** 8/12GB LPDDR5X
- **Storage:** Project size < 120MB (lebih ringan)
- **Battery:** Optimasi power: 60-120 FPS adaptive + low power mode
- **Gaming Features:** GT Triggers support (Special & Super)
- **OS:** Android 15 + XOS 15 → Target API 34-35

**Optimasi Khusus:**
- Godot 4.3/4.4 (sangat ringan untuk 2D)
- Adaptive FPS + V-Sync
- Efficient sprite animation
- Touch + Hardware trigger mapping

---

## 2. GAME DESIGN DOCUMENT (GDD) - FINAL

### Judul Game
**Niu-Fight**

### Storyline Utama (Story Mode)
Di masa keemasan Nusantara, sebuah turnamen suci diadakan untuk menentukan "Pahlawan Nusantara". Pemain memilih satu dari 4 legenda dan menjalani perjalanan melawan 3 lawan berturut-turut. Setiap kemenangan membuka cerita dan ending yang berbeda. Cerita ringan tapi immersive dengan dialog teks.

### Gameplay Core
- **Tipe:** 2D Side-Scrolling Fighter (mobile-optimized)
- **Rounds:** Best of 3 (3 rounds per match)
- **Modes:**
  - **Arcade Mode**: Lawan 3 AI berturut-turut (Easy → Hard)
  - **Story Mode**: 4 chapter (satu per karakter) dengan narasi + boss fight
  - **Training Mode**: Latihan gerakan
- **Controls:** Touch-friendly (Virtual Joystick + Buttons) + GT Triggers

### 4 Karakter (Playstyle Unik)

1. **Gajah Mada (Majapahit)** - Grappler / Tank
   - Senjata: Gadha berat
   - Playstyle: Kuat, lambat, ground pound
   - Special 1: Sumpah Palapa (rage + area damage)
   - Special 2: Majapahit Slam
   - Super: Palapa Nova

2. **Naga Samudra (Srivijaya)** - Zoner / Projectile
   - Senjata: Trisula + magic
   - Playstyle: Jarak jauh, summon gelombang
   - Special 1: Naga Strike (dash multi-hit)
   - Special 2: Water Spear
   - Super: Tsunami Call

3. **Garuda Singhasari (Singhasari)** - Aerial / Rushdown
   - Senjata: Cakar + sayap
   - Playstyle: Cepat, aerial combos
   - Special 1: Tornado Wing
   - Special 2: Garuda Dive
   - Super: Garuda Dive Bomb

4. **Keris Emas (Mataram)** - Precision / Counter
   - Senjata: Keris pusaka
   - Playstyle: Cepat, parry, counter
   - Special 1: Shadow Clone (3 clones)
   - Special 2: Keris Thrust
   - Super: Keris Illusion

Setiap karakter punya:
- 4 tombol serangan (Light Punch, Heavy Punch, Light Kick, Heavy Kick)
- 2 Special Moves (via tombol khusus)
- 1 Super Move (saat meter penuh)
- Win/Lose animation + quote

### Stage (4 Stages)
1. Candi Borobudur (Malam) - Majapahit
2. Pelabuhan Srivijaya (Pantai) - Srivijaya
3. Gunung Merapi (Volcano) - Singhasari
4. Hutan Suci Pajajaran - Mataram

### Controls (Touch Optimized)
- **Kiri:** Virtual Joystick (bergerak)
- **Kanan:**
  - 4 tombol serangan besar
  - Tombol Special (2 tombol)
  - Tombol Super (hanya saat meter penuh)
- **GT Triggers:** Left = Special, Right = Super
- Gesture: Swipe up = Jump, Double tap = Dash

### Visual & Audio
- **Art Style:** Pixel art high-res + glow effect (emas, merah, hijau)
- **UI:** Tema kerajaan (ornamen wayang + batik)
- **Music:** Gamelan fusion (epic)
- **SFX:** Impact punch, magic, clash

### Technical Specs (Ringan)
- Resolution: 1920x1080 (scale ke 1.5K)
- Target FPS: 120 (adaptive)
- File Size: < 120MB APK
- Android: API 34+
- Permissions: Tidak ada (kecuali storage opsional)

---

## 3. TEKNOLOGI

**Engine:** Godot 4.3 (ringan, 2D performance terbaik)
**Bahasa:** GDScript
**Asset:** Generate via AI → Pixel art style
**Build:** Export langsung ke APK (Android)

**Workspace Structure:**
```
/niu_fight/
├── project.godot
├── export_presets.cfg
├── assets/
│   ├── characters/
│   │   ├── gajahmada/
│   │   ├── nagasamudra/
│   │   ├── garudasinghasari/
│   │   └── kerisemas/
│   ├── stages/
│   ├── ui/
│   └── audio/
├── scenes/
│   ├── main_menu.tscn
│   ├── character_select.tscn
│   ├── fight_arena.tscn
│   ├── story_mode.tscn
│   └── training.tscn
├── scripts/
│   ├── fighter_base.gd
│   ├── player.gd
│   ├── ai_controller.gd
│   ├── game_manager.gd
│   ├── story_manager.gd
│   └── ...
└── README.md
```

---

## 4. LANGKAH EKSEKUSI (FINAL)

### Fase 1: Setup & Asset (Sekarang)
1. Buat project Godot + struktur folder
2. Setup export Android (API 34, landscape, 120FPS)
3. Generate 4 karakter sprites (idle, walk, attack, special, hit, win, lose)
4. Generate 4 background stages + parallax
5. Generate UI (health bar, buttons, menu)

### Fase 2: Core Fighting System
1. Fighter Base (state machine, hitbox, animation)
2. Input System (touch joystick + buttons + trigger support)
3. Fight Arena (camera, round system, win condition)
4. Implementasi 4 karakter + special moves

### Fase 3: Modes
1. AI Controller (3 difficulty)
2. Arcade Mode (3 lawan berturut-turut)
3. Story Mode (4 chapter + dialog + ending berbeda)
4. Main Menu + Character Select + Training

### Fase 4: Polish & Optimasi
1. Particle + screen shake
2. GT Trigger mapping
3. Performance tuning (120FPS target)
4. Icon & splash screen

### Fase 5: Final Build
1. Export APK
2. Dokumentasi lengkap untuk Hermes Agent
3. README + cara build

---

## 5. KRITERIA KEBERHASILAN
- [ ] APK berjalan di Android 15
- [ ] 120 FPS stabil
- [ ] 4 karakter playable dengan special moves
- [ ] Story Mode + Arcade Mode berfungsi
- [ ] Controls touch + GT Triggers
- [ ] Tema Nusantara kuat
- [ ] File size < 120MB
- [ ] Dokumentasi lengkap

---

**Rencana ini sudah diupdate sesuai permintaanmu.**  
Sekarang saya akan mulai eksekusi **Fase 1** (setup project + generate assets).

Apakah sudah siap? Ketik **"MULAI"** untuk saya mulai membuat project Godot sekarang.