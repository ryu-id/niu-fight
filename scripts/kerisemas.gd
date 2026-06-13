extends "res://scripts/player.gd"

func _ready():
	super._ready()
	move_speed = 480.0
	attack_damage = 14
	max_health = 100
	current_health = max_health
	current_state = "kerisemas"

func perform_special():
	if is_attacking or is_hit or is_dead:
		return
	is_attacking = true
	play_anim("special_shadow")
	gain_super(25.0)
	# Teleport behind opponent
	var opponent = find_opponent()
	if opponent:
		global_position.x = opponent.global_position.x + (-120 if is_facing_right else 120)
		# Flip to face opponent
		if (is_facing_right and opponent.global_position.x < global_position.x) or \
		   (not is_facing_right and opponent.global_position.x > global_position.x):
			flip_direction()
	else:
		velocity.x = 400.0 if is_facing_right else -400.0
	await get_tree().create_timer(0.3).timeout
	is_attacking = false

func perform_super():
	if super_meter < 100 or is_dead:
		return
	super_meter = 0
	emit_signal("super_changed", super_meter)
	is_attacking = true
	play_anim("super_illusion")
	# Multiple quick attacks
	for i in range(3):
		attack_damage = 20
		hitbox.monitoring = true
		await get_tree().create_timer(0.2).timeout
		hitbox.monitoring = false
		attack_damage = 14
		await get_tree().create_timer(0.15).timeout
	is_attacking = false

func find_opponent():
	var arena = get_tree().get_first_node_in_group("arena")
	if arena and arena.has_method("get_opponent"):
		return arena.get_opponent(self)
	return null
