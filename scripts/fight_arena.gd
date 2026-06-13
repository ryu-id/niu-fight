extends Node2D

@onready var player1_container: Node2D = $Player1Container
@onready var player2_container: Node2D = $Player2Container
@onready var p1_health_bar: ProgressBar = $UI/Player1Health
@onready var p2_health_bar: ProgressBar = $UI/Player2Health
@onready var p1_name: Label = $UI/Player1Name
@onready var p2_name: Label = $UI/Player2Name
@onready var round_label: Label = $UI/RoundLabel
@onready var timer_label: Label = $UI/TimerLabel
@onready var super_p1: ProgressBar = $UI/SuperMeterP1
@onready var super_p2: ProgressBar = $UI/SuperMeterP2
@onready var background: Sprite2D = $Background

var round_time: int = 99
var round_timer: Timer
var player1: Player
var player2: Player
var fight_active: bool = false

# Character configs: name, script_path, sprite_path, stats
var character_configs = {
	"gajahmada": {
		"name": "GAJAH MADA",
		"script": "res://scripts/gajah_mada.gd",
		"sprite": "res://assets/characters/gajahmada/idle.png",
		"stage": "res://assets/stages/borobudur.png",
		"stage_name": "STAGE: CANDI BOROBUDUR",
		"kingdom": "Majapahit"
	},
	"nagasamudra": {
		"name": "NAGA SAMUDRA",
		"script": "res://scripts/naga_samudra.gd",
		"sprite": "res://assets/characters/nagasamudra/idle.png",
		"stage": "res://assets/stages/srivijaya_port.png",
		"stage_name": "STAGE: PELABUHAN SRIVIJAYA",
		"kingdom": "Srivijaya"
	},
	"garudasinghasari": {
		"name": "GARUDA SINGHASARI",
		"script": "res://scripts/garudasinghasari.gd",
		"sprite": "res://assets/characters/garudasinghasari/idle.png",
		"stage": "res://assets/stages/merapi.png",
		"stage_name": "STAGE: GUNUNG MERAPI",
		"kingdom": "Singhasari"
	},
	"kerisemas": {
		"name": "KERIS EMAS",
		"script": "res://scripts/kerisemas.gd",
		"sprite": "res://assets/characters/kerisemas/idle.png",
		"stage": "res://assets/stages/pajajaran_forest.png",
		"stage_name": "STAGE: HUTAN PAJAJARAN",
		"kingdom": "Mataram"
	}
}

func _ready():
	var gm = get_node("/root/GameManager") as GameManager
	if gm:
		load_characters(gm.selected_character, gm.opponent_character)
		round_label.text = "ROUND " + str(gm.current_round)
	else:
		# Fallback: Gajah Mada vs Naga Samudra
		load_characters("gajahmada", "nagasamudra")
	
	# Setup timer
	round_timer = Timer.new()
	add_child(round_timer)
	round_timer.wait_time = 1.0
	round_timer.timeout.connect(_on_round_timer_tick)
	round_timer.start()
	
	fight_active = true

func load_characters(player_char: String, opponent_char: String):
	var p1_config = character_configs.get(player_char, character_configs["gajahmada"])
	var p2_config = character_configs.get(opponent_char, character_configs["nagasamudra"])
	
	# Set background
	var stage_tex = load(p1_config["stage"])
	if stage_tex and background:
		background.texture = stage_tex
	
	# Set stage label
	$StageLabel.text = p1_config["stage_name"]
	
	# Create Player 1
	player1 = create_fighter(p1_config, 1)
	if player1:
		player1_container.add_child(player1)
		player1.position = Vector2.ZERO
		player1.is_facing_right = true
		player1.sprite.flip_h = false
	
	# Create Player 2
	player2 = create_fighter(p2_config, 2)
	if player2:
		player2_container.add_child(player2)
		player2.position = Vector2.ZERO
		player2.is_facing_right = false
		player2.sprite.flip_h = true
		# Add AI controller
		var ai = load("res://scripts/ai_controller.gd").new()
		ai.fighter = player2
		player2.is_ai = true
		player2_container.add_child(ai)
	
	# Connect signals
	if player1:
		player1.health_changed.connect(_on_p1_health)
		player1.super_changed.connect(_on_p1_super)
		player1.died.connect(_on_p1_died)
		p1_health_bar.max_value = player1.max_health
		p1_health_bar.value = player1.max_health
		p1_name.text = p1_config["name"]
	
	if player2:
		player2.health_changed.connect(_on_p2_health)
		player2.super_changed.connect(_on_p2_super)
		player2.died.connect(_on_p2_died)
		p2_health_bar.max_value = player2.max_health
		p2_health_bar.value = player2.max_health
		p2_name.text = p2_config["name"]

func create_fighter(config: Dictionary, pid: int) -> Player:
	var script_res = load(config["script"])
	if not script_res:
		return null
	
	var fighter = CharacterBody2D.new()
	fighter.set_script(script_res)
	fighter.player_id = pid
	fighter.is_ai = (pid == 2)
	
	# Add sprite
	var spr = Sprite2D.new()
	spr.texture = load(config["sprite"])
	spr.scale = Vector2(1.5, 1.5)
	spr.name = "Sprite2D"
	fighter.add_child(spr)
	fighter.sprite = spr
	
	# Add collision
	var col = CollisionShape2D.new()
	var rect = RectangleShape2D.new()
	rect.size = Vector2(80, 160)
	col.shape = rect
	col.position = Vector2(0, 80)
	col.name = "CollisionShape2D"
	fighter.add_child(col)
	fighter.collision = col
	
	# Add hurtbox
	var hb = Area2D.new()
	hb.name = "Hurtbox"
	hb.position = Vector2(0, 80)
	hb.collision_layer = 2
	var hb_shape = CollisionShape2D.new()
	var hb_rect = RectangleShape2D.new()
	hb_rect.size = Vector2(140, 180)
	hb_shape.shape = hb_rect
	hb.add_child(hb_shape)
	fighter.add_child(hb)
	fighter.hurtbox = hb
	
	# Add hitbox
	var hitb = Area2D.new()
	hitb.name = "Hitbox"
	hitb.position = Vector2(50, 40)
	hitb.collision_layer = 0
	hitb.collision_mask = 2
	hitb.add_to_group("hitbox_target")
	var hitb_shape = CollisionShape2D.new()
	var hitb_rect = RectangleShape2D.new()
	hitb_rect.size = Vector2(80, 160)
	hitb_shape.shape = hitb_rect
	hitb.add_child(hitb_shape)
	fighter.add_child(hitb)
	fighter.hitbox = hitb
	fighter.add_to_group("hitbox_target")
	
	# Add animation player
	var anim_player = AnimationPlayer.new()
	anim_player.name = "AnimationPlayer"
	fighter.add_child(anim_player)
	fighter.animation_player = anim_player
	
	return fighter

func _on_round_timer_tick():
	if not fight_active:
		return
	round_time -= 1
	timer_label.text = str(round_time)
	if round_time <= 0:
		end_round("timeout")

func _on_p1_health(val: int):
	p1_health_bar.value = val

func _on_p2_health(val: int):
	p2_health_bar.value = val

func _on_p1_super(val: float):
	super_p1.value = val

func _on_p2_super(val: float):
	super_p2.value = val

func _on_p1_died():
	end_round("player2")

func _on_p2_died():
	end_round("player1")

func get_opponent(fighter_node):
	if fighter_node == player1:
		return player2
	elif fighter_node == player2:
		return player1
	return null

func end_round(winner: String):
	if not fight_active:
		return
	fight_active = false
	round_timer.stop()
	
	var result_label = Label.new()
	result_label.add_theme_font_size_override("font_size", 56)
	result_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	result_label.position = Vector2(500, 420)
	
	match winner:
		"player1":
			result_label.text = "MENANG!"
			result_label.modulate = Color(0.2, 1, 0.3)
		"player2":
			result_label.text = "KALAH..."
			result_label.modulate = Color(1, 0.3, 0.3)
		_:
			result_label.text = "WAKTU HABIS"
			result_label.modulate = Color(1, 1, 0.4)
	
	add_child(result_label)
	
	await get_tree().create_timer(2.5).timeout
	
	var gm = get_node("/root/GameManager") as GameManager
	if gm:
		gm.end_round(winner)
	
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
