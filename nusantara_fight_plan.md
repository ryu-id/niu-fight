# RENCANA MATANG: Game Android "Nusantara Kingdom Clash" (Fighting Game)
## Target: Infinix GT 30 Pro (Perfect Optimization)

**Tanggal Rencana:** 2026-06-13 (Asia/Jakarta)
**Genre:** 2D Fighting Game (Arcade-style side-view fighter)
**Tema:** Kerajaan-kerajaan Nusantara pra-Indonesia (Majapahit, Srivijaya, Singhasari, Mataram, Kediri, Pajajaran)
**Tujuan:** Game sempurna, playable, optimized untuk device gaming high-end ini, siap di-build menjadi APK yang bisa langsung di-install dan dimainkan.

---

## 1. ANALISIS DEVICE TARGET (Infinix GT 30 Pro)
- **Chipset:** MediaTek Dimensity 8350 Ultimate (4nm) + Mali-G615 MC6 GPU → Sangat kuat untuk 2D high-FPS (144Hz)
- **Display:** 6.78" 1.5K AMOLED 144Hz, Gorilla Glass 7i → Target 120-144 FPS smooth
- **RAM:** 8/12GB LPDDR5X → Bisa load banyak assets + AI logic
- **Storage:** 256/512GB UFS 4.0 → Project size < 200MB
- **Battery:** 5500mAh + 45W fast charge → Optimasi power: 60-90 FPS default, adaptive
- **Gaming Features:** 
  - GT Triggers (pressure sensitive shoulder buttons) → Map ke Special Attacks
  - XBoost Gaming Engine + AI cooling → Full performance mode
  - RGB LEDs → Integrate subtle RGB feedback (jika API support)
- **OS:** Android 15 + XOS 15 → Target API 34-35, support modern features
- **Kelebihan:** Touch screen besar, high refresh → Controls responsif + visual smooth

**Optimasi Khusus:**
- Gunakan V-Sync + adaptive refresh
- Efficient particle effects (Godot 2D)
- Low battery drain mode option
- Support hardware triggers via Android Input

---

## 2. GAME DESIGN DOCUMENT (GDD) - RINGKAS

### Judul Game
**"NUSANTARA: Kingdom Clash - Fight of the Archipelago"**  
(atau "Perang Kerajaan Nusantara")

### Storyline Singkat
Di era keemasan Nusantara sebelum penjajahan, para raja dan patih dari berbagai kerajaan berkumpul di sebuah turnamen sakral untuk menentukan siapa yang layak memimpin seluruh Nusantara. Pemain memilih warrior legendaris dari kerajaan masing-masing dan bertarung di medan perang bersejarah.

### Gameplay Core
- **Tipe:** 2D Side-Scrolling Fighter (mirip Street Fighter / Mortal Kombat tapi simplified untuk mobile)
- **Rounds:** Best of 3 (3 rounds per match)
- **Controls:** Touch-optimized + Hardware trigger support
- **Modes:**
  - Arcade (Single Player vs AI)
  - Local VS (2 players on one device - split controls atau pass-and-play)
  - Training Mode
  - Story Mode (simple branching narrative)

### Karakter (6 Playable - Masing-masing unik playstyle)
1. **Gajah Mada (Majapahit Empire)** - Grappler/Tank
   - Senjata: Gadha (mace) berat
   - Playstyle: Kuat, lambat, combo ground pound
   - Special: Sumpah Palapa (rage mode + area damage)
   - Super: Palapa Nova

2. **Naga Samudra (Srivijaya Kingdom)** - Zoner/Rushdown hybrid
   - Senjata: Trisula + magic air
   - Playstyle: Agile, summon gelombang, proyektil
   - Special: Naga Strike (dash + multi hit)
   - Super: Tsunami Call

3. **Garuda Singhasari (Singhasari Kingdom)** - Aerial/Rushdown
   - Senjata: Cakar + sayap
   - Playstyle: Cepat, aerial combos, dive attacks
   - Special: Tornado Wing
   - Super: Garuda Dive Bomb

4. **Keris Emas (Mataram Kingdom)** - Precision/Footsies
   - Senjata: Keris pusaka
   - Playstyle: Cepat, parry, counter attack
   - Special: Shadow Clone (3 clones attack)
   - Super: Keris Illusion

5. **Raja Brawijaya (Kediri Kingdom)** - Balanced All-rounder
   - Senjata: Pedang + tombak
   - Playstyle: Balanced speed/power
   - Special: Api Kerajaan (fire slash)
   - Super: Brawijaya Charge

6. **Patih Siliwangi (Pajajaran Kingdom)** - Defensive/Counter
   - Senjata: Tombak + perisai
   - Playstyle: Defense first, punish
   - Special: Perisai Suci
   - Super: Siliwangi Wall

Setiap karakter punya:
- 4 attack buttons (LP, HP, LK, HK)
- 2-3 special moves (motion input: quarter circle forward/back + button)
- 1 Super/Ultra
- Unique win animation + voice line (text-based)

### Stage / Background (5 Stages)
1. Candi Borobudur (Mataram/Majapahit) - Malam berbintang
2. Pelabuhan Srivijaya (pantai + kapal)
3. Gunung Merapi (volcano field - Singhasari)
4. Hutan Pajajaran (rimba)
5. Istana Kediri (istana megah)

### Controls (Touch Optimized untuk Phone)
- **Left side:** Virtual Joystick (atau D-pad 4 arah)
- **Right side:** 
  - 4 attack buttons (besar, mudah dijangkau ibu jari)
  - 1 Special button
  - 1 Super button (hanya saat meter penuh)
- **Hardware GT Triggers:** Left trigger = Special, Right trigger = Super
- **Gesture:** Swipe up = Jump, Double tap = Dash
- Responsif 144Hz: Input latency sangat rendah

### Visual & Audio Style
- **Art:** Pixel art high-res (atau semi-pixel dengan detail) + efek glow untuk kerajaan theme (emas, merah, hijau)
- **Animation:** Smooth frame-by-frame (8-12 frames per action)
- **UI:** Tema kerajaan (ornamen wayang, batik pattern)
- **Music:** Gamelan + orchestral fusion (epic battle music) - royalty free atau generated
- **SFX:** Punch/kick impact, keris clash, magic sounds

### Technical Specs
- **Resolution:** 1920x1080 (dengan scaling untuk 1.5K)
- **FPS Target:** 120-144 FPS
- **File Size:** <150MB (APK)
- **Android Target:** API 34+ (Android 14/15)
- **Permissions:** None extra (hanya storage untuk save jika perlu)

---

## 3. TEKNOLOGI & TOOLS YANG AKAN DIGUNAKAN

**Engine Utama: Godot 4.4+ (atau 4.3 stable)**
- Alasan:
  - Export Android native & sangat bagus
  - 2D performance excellent di Mali GPU
  - GDScript mudah & cepat
  - Built-in physics, animation, particle
  - Support 144Hz + adaptive refresh
  - Export APK langsung + support Play Store

**Bahasa:** GDScript (primary) + sedikit C# jika perlu

**Asset Pipeline:**
- Sprites: Generate dengan AI image tool (generate_image) → pixel art style
- Background: Generate_image + simple parallax
- Animation: SpriteSheets
- Audio: Placeholder (atau free assets)

**Build & Export:**
- Godot Android export template
- Gradle untuk custom (jika perlu)
- Target: Signed APK atau AAB

**Workspace Structure:**
```
/nusantara_fight/
├── project.godot
├── export_presets.cfg
├── assets/
│   ├── characters/
│   │   ├── gajahmada/
│   │   ├── naga/
│   │   └── ...
│   ├── stages/
│   ├── ui/
│   └── audio/
├── scenes/
│   ├── main_menu.tscn
│   ├── character_select.tscn
│   ├── fight_arena.tscn
│   └── ...
├── scripts/
│   ├── player.gd
│   ├── fighter_base.gd
│   ├── ai_controller.gd
│   ├── game_manager.gd
│   └── ...
├── addons/ (jika perlu)
└── README.md (build instructions)
```

---

## 4. LANGKAH-LANGKAH EKSEKUSI (MATANG & BERURUTAN)

### Fase 1: Persiapan (Selesai dalam 1-2 iterasi)
1. Buat folder project + project.godot
2. Setup Godot export untuk Android (target API 34, orientation landscape, 144Hz support)
3. Generate semua sprite character (6 karakter × multiple animations: idle, walk, punch, kick, special, hit, win, lose)
4. Generate background stages + parallax layers
5. Generate UI elements (health bar, buttons, menu)

### Fase 2: Core Systems (Paling Kritis)
1. **Fighter Base Class** (player.gd + fighter_base.gd)
   - State machine: Idle, Walk, Jump, Attack, Block, Hitstun, Special, Super
   - Input handler (touch + keyboard untuk testing)
   - Health, meter, combo system
   - Collision (hurtbox/hitbox)
   - Animation player + sprite flip

2. **Input System**
   - Virtual joystick + button overlay (Control nodes)
   - Support hardware gamepad/triggers (InputEventJoypad)
   - Motion input detection (quarter circle)

3. **Fight Arena Scene**
   - Camera follow (2 player)
   - Stage background + parallax
   - Round timer + win condition
   - Pause menu

4. **Character Implementation** (6 unique)
   - Setiap karakter inherit dari base + override specials
   - Unique stats (speed, power, defense)
   - Special move logic

### Fase 3: AI & Modes
1. **Simple AI** (rule-based atau state machine sederhana)
   - Difficulty: Easy/Medium/Hard
2. **Game Manager** (scene transitions, save progress, scoring)
3. **Menus:**
   - Main menu (dengan background animasi)
   - Character select (6 portraits + stats)
   - Options (controls, graphics quality, FPS cap)

### Fase 4: Polish & Optimization
1. Particle effects (dust, hit sparks, magic)
2. Screen shake on heavy hits
3. Sound integration (placeholder dulu)
4. Performance: Set max FPS, batching, etc.
5. Test di device specs (simulate high refresh)
6. Add GT Triggers mapping note

### Fase 5: Build & Final
1. Export APK (debug + release)
2. Buat README lengkap + build instructions untuk Hermes agent
3. Tambahkan icon, splash screen bertema kerajaan
4. Dokumentasi lengkap (cara main, controls)

---

## 5. RISIKO & MITIGASI
- **Risiko 1:** Asset creation terlalu banyak → Mitigasi: Mulai dengan placeholder colored rectangles + basic shapes, lalu upgrade ke generated sprites. Prioritaskan 4 karakter dulu jika waktu.
- **Risiko 2:** Input motion detection rumit di touch → Mitigasi: Gunakan button khusus + gesture sederhana. Special moves via dedicated buttons dulu.
- **Risiko 3:** Godot export complex di sandbox → Mitigasi: Buat project lengkap + export_presets.cfg + instructions detail. User/Hermes bisa export di local machine.
- **Risiko 4:** Performance di 144Hz → Mitigasi: Godot sangat bagus di 2D. Gunakan fixed timestep + cap FPS jika perlu.
- **Risiko 5:** File size besar → Mitigasi: Compress textures, gunakan .import settings optimal.

---

## 6. KRITERIA KEBERHASILAN "SEMPURNA"
- [ ] Bisa di-build menjadi APK yang berjalan di Android 15
- [ ] 60+ FPS stabil di device (target 120+)
- [ ] Semua 6 karakter playable dengan minimal 2 special moves masing-masing
- [ ] Controls touch-friendly & responsif
- [ ] AI bisa dikalahkan tapi menantang
- [ ] Visual tema Nusantara kuat (ornamen, warna, nama)
- [ ] Tidak crash, smooth transition
- [ ] Dokumentasi lengkap untuk eksekusi selanjutnya

---

## 7. NEXT STEP
Setelah user menyetujui rencana ini, saya akan mulai eksekusi Fase 1 secara bertahap di workspace ini.

Apakah rencana ini sudah sesuai? Ada yang ingin diubah/ditambahkan (misal: jumlah karakter, mode tambahan, atau tech stack lain seperti Unity/Flutter)?

Saya siap eksekusi segera setelah konfirmasi.