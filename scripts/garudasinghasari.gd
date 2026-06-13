extends "res://scripts/player.gd"

func _ready():
	super._ready()
	move_speed = 500.0
	attack_damage = 9
	max_health = 90
	current_health = max_health
	current_state = "garudasinghasari"

func perform_special():
	if is_attacking or is_hit or is_dead:
		return
	is_attacking = true
	play_anim("special_tornado")
	gain_super(25.0)
	velocity.y = -500.0
	velocity.x = 200.0 if is_facing_right else -200.0
	await get_tree().create_timer(0.7).timeout
	is_attacking = false

func perform_super():
	if super_meter < 100 or is_dead:
		return
	super_meter = 0
	emit_signal("super_changed", super_meter)
	is_attacking = true
	play_anim("super_divebomb")
	velocity.y = -600.0
	await get_tree().create_timer(0.5).timeout
	velocity.y = 800.0
	attack_damage = 40
	hitbox.monitoring = true
	await get_tree().create_timer(0.3).timeout
	hitbox.monitoring = false
	attack_damage = 9
	await get_tree().create_timer(0.5).timeout
	is_attacking = false
