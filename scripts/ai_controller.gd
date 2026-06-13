extends Node
class_name AIController

@export var difficulty: int = 2
@export var reaction_time: float = 0.4

var fighter: Player
var opponent: Player
var decision_timer: float = 0.0
var next_action_time: float = 0.8
var is_pressing_left: bool = false
var is_pressing_right: bool = false

func _ready():
	await get_tree().process_frame
	# Find fighter from parent or sibling
	if not fighter:
		fighter = get_parent() as Player
	if not fighter:
		fighter = get_parent().get_node_or_null(".") as Player
	
	# Find opponent from the other player container
	if not opponent:
		var arena = get_tree().get_first_node_in_group("arena")
		if not arena:
			arena = get_node("/root/FightArena")
		if arena and arena.has_method("get_opponent"):
			opponent = arena.get_opponent(fighter)

func _process(delta):
	if not fighter or fighter.is_dead or fighter.is_hit or fighter.is_attacking:
		release_all()
		return
	
	# Re-find opponent if needed
	if not opponent or not is_instance_valid(opponent):
		opponent = find_opponent()
		if not opponent:
			return
	
	decision_timer += delta
	if decision_timer >= next_action_time:
		make_decision()
		decision_timer = 0.0
		next_action_time = randf_range(0.35, 1.0) * (2.5 / max(difficulty, 1))

func find_opponent() -> Player:
	var arena = get_tree().get_first_node_in_group("arena")
	if arena and arena.has_method("get_opponent"):
		return arena.get_opponent(fighter)
	# Fallback: find any player not us
	for p in get_tree().get_nodes_in_group("player"):
		if p != fighter and p is Player:
			return p
	return null

func make_decision():
	if not opponent or not is_instance_valid(opponent):
		return
	
	var distance = abs(fighter.global_position.x - opponent.global_position.x)
	
	# Use super if available
	if fighter.super_meter >= 100 and randf() < 0.15:
		simulate_press("p2_super" if fighter.player_id == 2 else "p1_super")
		return
	
	# Decision tree based on distance
	if distance > 500:
		# Far: move towards or use special
		if randf() < 0.6:
			move_towards_opponent()
		elif randf() < 0.5:
			simulate_press("p2_special" if fighter.player_id == 2 else "p1_special")
	
	elif distance < 120:
		# Very close: mix of blocking and attacking
		if randf() < 0.5:
			attack()
		elif randf() < 0.4:
			fighter.is_blocking = true
			await get_tree().create_timer(0.5).timeout
			fighter.is_blocking = false
	
	else:
		# Mid range: mostly attack
		if randf() < 0.65:
			attack()
		else:
			move_towards_opponent()

func move_towards_opponent():
	if not opponent:
		return
	var dir = sign(opponent.global_position.x - fighter.global_position.x)
	
	release_all()
	var action = "p2_right" if dir > 0 else "p2_left"
	if fighter.player_id == 1:
		action = "p1_right" if dir > 0 else "p1_left"
	
	Input.action_press(action)
	is_pressing_left = (dir < 0)
	is_pressing_right = (dir > 0)
	
	# Release after a short burst
	await get_tree().create_timer(0.3).timeout
	release_all()
	
	# Sometimes jump
	if randf() < 0.2:
		simulate_press("p2_up" if fighter.player_id == 2 else "p1_up")

func attack():
	var choice = randi() % 6
	match choice:
		0: simulate_press("p2_lp" if fighter.player_id == 2 else "p1_lp")
		1: simulate_press("p2_hp" if fighter.player_id == 2 else "p1_hp")
		2: simulate_press("p2_lk" if fighter.player_id == 2 else "p1_lk")
		3: simulate_press("p2_hk" if fighter.player_id == 2 else "p1_hk")
		4: simulate_press("p2_special" if fighter.player_id == 2 else "p1_special")
		_:
			fighter.is_blocking = true
			await get_tree().create_timer(0.4).timeout
			fighter.is_blocking = false

func simulate_press(action: String):
	Input.action_press(action)
	await get_tree().create_timer(0.08).timeout
	Input.action_release(action)

func release_all():
	var prefix = "p2_" if fighter.player_id == 2 else "p1_"
	Input.action_release(prefix + "left")
	Input.action_release(prefix + "right")
	is_pressing_left = false
	is_pressing_right = false
