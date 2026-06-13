extends "res://scripts/player.gd"

func _ready():
	super._ready()
	move_speed = 380.0
	attack_damage = 15
	max_health = 120

func perform_special():
	is_attacking = true
	animation_player.play("special_sumpah")
	gain_super(25)
	await get_tree().create_timer(0.8).timeout
	# Area damage effect
	is_attacking = false

func perform_super():
	if super_meter >= 100:
		super_meter = 0
		is_attacking = true
		animation_player.play("super_palapa")
	await get_tree().create_timer(1.2).timeout
	is_attacking = false