extends Node2D

@onready var player1_health: ProgressBar = $UI/Player1Health
@onready var player2_health: ProgressBar = $UI/Player2Health
@onready var round_label: Label = $UI/RoundLabel
@onready var timer_label: Label = $UI/TimerLabel
@onready var super_p1: ProgressBar = $UI/SuperMeterP1
@onready var super_p2: ProgressBar = $UI/SuperMeterP2
@onready var stage_label: Label = $StageLabel
@onready var background: Sprite2D = $Background

var round_time: int = 99
var round_timer: Timer
var player1: FighterBase
var player2: FighterBase
var game_manager: GameManager

func _ready():
	game_manager = get_node("/root/GameManager") if has_node("/root/GameManager") else null
	
	player1 = $Player1
	player2 = $Player2
	
	if player1:
		player1.health_changed.connect(_on_p1_health_changed)
		player1.super_changed.connect(_on_p1_super_changed)
		player1.died.connect(_on_p1_died)
	
	if player2:
		player2.health_changed.connect(_on_p2_health_changed)
		player2.super_changed.connect(_on_p2_super_changed)
		player2.died.connect(_on_p2_died)
	
	round_timer = Timer.new()
	add_child(round_timer)
	round_timer.wait_time = 1.0
	round_timer.timeout.connect(_on_round_timer)
	round_timer.start()
	
	update_ui()
	setup_stage_and_characters()

func setup_stage_and_characters():
	var stage_texture: Texture2D
	
	if game_manager:
		match game_manager.selected_character:
			"gajahmada":
				stage_texture = load("res://assets/stages/borobudur.png")
				stage_label.text = "STAGE: CANDI BOROBUDUR"
			"nagasamudra":
				stage_texture = load("res://assets/stages/srivijaya_port.png")
				stage_label.text = "STAGE: PELABUHAN SRIVIJAYA"
			"garudasinghasari":
				stage_texture = load("res://assets/stages/merapi.png")
				stage_label.text = "STAGE: GUNUNG MERAPI"
			"kerisemas":
				stage_texture = load("res://assets/stages/pajajaran_forest.png")
				stage_label.text = "STAGE: HUTAN PAJAJARAN"
			_:
				stage_texture = load("res://assets/stages/borobudur.png")
	else:
		stage_texture = load("res://assets/stages/borobudur.png")
	
	if stage_texture and background:
		background.texture = stage_texture

func _on_round_timer():
	round_time -= 1
	timer_label.text = str(round_time)
	
	if round_time <= 0:
		end_round("timeout")

func _on_p1_health_changed(new_health):
	player1_health.value = new_health

func _on_p2_health_changed(new_health):
	player2_health.value = new_health

func _on_p1_super_changed(new_meter):
	super_p1.value = new_meter

func _on_p2_super_changed(new_meter):
	super_p2.value = new_meter

func _on_p1_died():
	end_round("player2")

func _on_p2_died():
	end_round("player1")

func update_ui():
	round_label.text = "ROUND " + str(1 if not game_manager else game_manager.current_round)

func end_round(winner: String):
	round_timer.stop()
	
	var result_label = Label.new()
	result_label.add_theme_font_size_override("font_size", 56)
	result_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	result_label.position = Vector2(500, 420)
	
	if winner == "player1":
		result_label.text = "MENANG!"
		result_label.modulate = Color(0.2, 1, 0.3)
	elif winner == "player2":
		result_label.text = "KALAH..."
		result_label.modulate = Color(1, 0.3, 0.3)
	else:
		result_label.text = "WAKTU HABIS"
		result_label.modulate = Color(1, 1, 0.4)
	
	add_child(result_label)
	
	await get_tree().create_timer(2.8).timeout
	
	if game_manager:
		game_manager.end_round(winner)
	
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")