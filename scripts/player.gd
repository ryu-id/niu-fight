extends FighterBase
class_name Player

@export var player_id: int = 1

var input_left: String
var input_right: String
var input_up: String
var input_down: String
var input_lp: String
var input_hp: String
var input_lk: String
var input_hk: String
var input_special: String
var input_super: String

func _ready():
	super._ready()
	setup_input()

func setup_input():
	if player_id == 1:
		input_left = "p1_left"
		input_right = "p1_right"
		input_up = "p1_up"
		input_down = "p1_down"
		input_lp = "p1_lp"
		input_hp = "p1_hp"
		input_lk = "p1_lk"
		input_hk = "p1_hk"
		input_special = "p1_special"
		input_super = "p1_super"
	else:
		input_left = "p2_left"
		input_right = "p2_right"
		input_up = "p2_up"
		input_down = "p2_down"
		input_lp = "p2_lp"
		input_hp = "p2_hp"
		input_lk = "p2_lk"
		input_hk = "p2_hk"
		input_special = "p2_special"
		input_super = "p2_super"

func _physics_process(delta):
	super._physics_process(delta)
	
	if is_hit or is_attacking:
		return
	
	handle_movement()
	handle_attacks()

func handle_movement():
	var direction = Input.get_axis(input_left, input_right)
	
	if direction:
		velocity.x = direction * move_speed
		if (direction > 0 and not is_facing_right) or (direction < 0 and is_facing_right):
			flip_direction()
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed * 1.5)
	
	if Input.is_action_just_pressed(input_up) and is_on_floor():
		velocity.y = jump_velocity

func handle_attacks():
	if Input.is_action_just_pressed(input_lp):
		perform_attack("light_punch", 8, 0.35)
	elif Input.is_action_just_pressed(input_hp):
		perform_attack("heavy_punch", 16, 0.45)
	elif Input.is_action_just_pressed(input_lk):
		perform_attack("light_kick", 9, 0.4)
	elif Input.is_action_just_pressed(input_hk):
		perform_attack("heavy_kick", 18, 0.5)
	elif Input.is_action_just_pressed(input_special):
		perform_special()
	elif Input.is_action_just_pressed(input_super) and super_meter >= 100:
		perform_super()