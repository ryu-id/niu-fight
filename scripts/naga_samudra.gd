extends "res://scripts/player.gd"

func _ready():
	super._ready()
	move_speed = 450.0
	attack_damage = 10
	max_health = 95
	current_health = max_health
	current_state = "nagasamudra"

func perform_special():
	if is_attacking or is_hit or is_dead:
		return
	is_attacking = true
	play_anim("special_naga")
	gain_super(30.0)
	velocity.y = -400.0
	await get_tree().create_timer(0.9).timeout
	is_attacking = false

func perform_super():
	if super_meter < 100 or is_dead:
		return
	super_meter = 0
	emit_signal("super_changed", super_meter)
	is_attacking = true
	play_anim("super_tsunami")
	attack_damage = 35
	hitbox.monitoring = true
	await get_tree().create_timer(0.5).timeout
	hitbox.monitoring = false
	attack_damage = 10
	await get_tree().create_timer(1.0).timeout
	is_attacking = false
