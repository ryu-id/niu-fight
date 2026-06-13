extends Node
class_name AIController

@export var difficulty: int = 2

var fighter: FighterBase
var opponent: FighterBase
var decision_timer: float = 0.0
var next_action_time: float = 0.8

func _ready():
	fighter = get_parent()
	opponent = get_tree().get_first_node_in_group("player1") as FighterBase

func _process(delta):
	if not fighter or not opponent or fighter.is_hit or fighter.is_attacking:
		return
	
	decision_timer += delta
	if decision_timer >= next_action_time:
		make_decision()
		decision_timer = 0.0
		next_action_time = randf_range(0.4, 1.1) * (3.5 / difficulty)

func make_decision():
	var distance = abs(fighter.global_position.x - opponent.global_position.x)
	
	if distance > 650:
		if randf() < 0.55:
			move_towards()
		else:
			use_special()
	elif distance < 140:
		if randf() < 0.65:
			attack()
		else:
			block()
	else:
		if randf() < 0.6:
			attack()
		else:
			move_towards()

func move_towards():
	var dir = 1 if fighter.global_position.x < opponent.global_position.x else -1
	Input.action_press("p2_right" if dir > 0 else "p2_left")
	await get_tree().create_timer(0.35).timeout
	Input.action_release("p2_right")
	Input.action_release("p2_left")

func attack():
	var choice = randi() % 4
	match choice:
		0: simulate_press("p2_lp")
		1: simulate_press("p2_hp")
		2: simulate_press("p2_lk")
		3: simulate_press("p2_hk")

func simulate_press(action: String):
	Input.action_press(action)
	await get_tree().create_timer(0.08).timeout
	Input.action_release(action)

func use_special():
	Input.action_press("p2_special")
	await get_tree().create_timer(0.1).timeout
	Input.action_release("p2_special")

func block():
	fighter.is_blocking = true
	await get_tree().create_timer(0.7).timeout
	fighter.is_blocking = false