extends Node2D

@onready var player: FighterBase = $Player
@onready var dummy: FighterBase = $Dummy

func _ready():
	# Simple training setup
	player.position = Vector2(600, 700)
	dummy.position = Vector2(1300, 700)
	
	# Make dummy static
	dummy.move_speed = 0

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")