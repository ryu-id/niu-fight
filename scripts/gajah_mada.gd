extends "res://scripts/player.gd"

func _ready():
	super._ready()
	move_speed = 380.0
	attack_damage = 15
	max_health = 120
	current_health = max_health
	current_state = "gajahmada"

func perform_special():
	if is_attacking or is_hit or is_dead:
		return
	is_attacking = true
	play_anim("special_sumpah")
	gain_super(25.0)
	velocity.y = -300.0
	await get_tree().create_timer(0.8).timeout
	is_attacking = false

func perform_super():
	if super_meter < 100 or is_dead:
		return
	super_meter = 0
	emit_signal("super_changed", super_meter)
	is_attacking = true
	play_anim("super_palapa")
	velocity.x = 500.0 if is_facing_right else -500.0
	await get_tree().create_timer(1.2).timeout
	is_attacking = false
