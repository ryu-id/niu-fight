extends "res://scripts/player.gd"

func _ready():
	super._ready()
	move_speed = 450.0
	attack_damage = 10
	max_health = 95

func perform_special():
	is_attacking = true
	animation_player.play("special_naga")
	gain_super(30)
	await get_tree().create_timer(0.9).timeout
	is_attacking = false

func perform_super():
	if super_meter >= 100:
		super_meter = 0
		is_attacking = true
		animation_player.play("super_tsunami")
	await get_tree().create_timer(1.5).timeout
	is_attacking = false