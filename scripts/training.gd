extends Node2D

@onready var player_container: Node2D = $Player
@onready var dummy_container: Node2D = $Dummy

var player: Player
var dummy: FighterBase

func _ready():
	# Create Player (Gajah Mada) the same way as fight_arena
	player = create_fighter("res://scripts/gajah_mada.gd", "res://assets/characters/gajahmada/idle.png", 1, false)
	if player:
		player_container.add_child(player)
		player.position = Vector2.ZERO
		player.is_facing_right = true
		player.sprite.flip_h = false
	
	# Create Dummy (simple player, no AI movement)
	dummy = create_fighter("res://scripts/player.gd", "res://assets/characters/kerisemas/idle.png", 2, true)
	if dummy:
		dummy_container.add_child(dummy)
		dummy.position = Vector2.ZERO
		dummy.is_facing_right = false
		dummy.sprite.flip_h = true
		dummy.move_speed = 0  # Make dummy stationary
		# Override so dummy doesn't attack
		dummy.set_script(null)
	
	# Connect dummy health for reset
	if dummy:
		dummy.health_changed.connect(_on_dummy_health)

func create_fighter(script_path: String, sprite_path: String, pid: int, is_ai_player: bool) -> Player:
	var script_res = load(script_path)
	if not script_res:
		return null
	
	var fighter = CharacterBody2D.new()
	fighter.set_script(script_res)
	fighter.player_id = pid
	fighter.is_ai = is_ai_player
	
	# Sprite
	var spr = Sprite2D.new()
	spr.texture = load(sprite_path)
	spr.scale = Vector2(1.8, 1.8)
	spr.name = "Sprite2D"
	fighter.add_child(spr)
	fighter.sprite = spr
	
	# Collision
	var col = CollisionShape2D.new()
	var rect = RectangleShape2D.new()
	rect.size = Vector2(80, 160)
	col.shape = rect
	col.position = Vector2(0, 80)
	col.name = "CollisionShape2D"
	fighter.add_child(col)
	fighter.collision = col
	
	# Hurtbox
	var hb = Area2D.new()
	hb.name = "Hurtbox"
	hb.position = Vector2(0, 80)
	hb.collision_layer = 2
	var hb_shape = CollisionShape2D.new()
	var hb_rect = RectangleShape2D.new()
	hb_rect.size = Vector2(140, 180)
	hb_shape.shape = hb_rect
	hb.add_child(hb_shape)
	fighter.add_child(hb)
	fighter.hurtbox = hb
	
	# Hitbox
	var hitb = Area2D.new()
	hitb.name = "Hitbox"
	hitb.position = Vector2(50, 40)
	hitb.collision_layer = 0
	hitb.collision_mask = 2
	var hitb_shape = CollisionShape2D.new()
	var hitb_rect = RectangleShape2D.new()
	hitb_rect.size = Vector2(80, 160)
	hitb_shape.shape = hitb_rect
	hitb.add_child(hitb_shape)
	fighter.add_child(hitb)
	fighter.hitbox = hitb
	
	# AnimationPlayer
	var anim = AnimationPlayer.new()
	anim.name = "AnimationPlayer"
	fighter.add_child(anim)
	fighter.animation_player = anim
	
	return fighter

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_dummy_health(val: int):
	if val <= 0:
		await get_tree().create_timer(1.5).timeout
		if is_instance_valid(dummy):
			dummy.current_health = dummy.max_health
			dummy.is_dead = false
			dummy.is_hit = false
			dummy.velocity = Vector2.ZERO
			dummy.emit_signal("health_changed", dummy.current_health)
