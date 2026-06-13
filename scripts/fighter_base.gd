extends CharacterBody2D
class_name FighterBase

@export var max_health: int = 100
@export var move_speed: float = 420.0
@export var jump_velocity: float = -950.0
@export var attack_damage: int = 12
@export var super_gain_rate: float = 8.0

var current_health: int = max_health
var is_facing_right: bool = true
var is_attacking: bool = false
var is_blocking: bool = false
var is_hit: bool = false
var is_dead: bool = false
var super_meter: float = 0.0
var current_state: String = "idle"
var combo_count: int = 0
var gravity: float = 980.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hitbox: Area2D = $Hitbox
@onready var hurtbox: Area2D = $Hurtbox
@onready var collision: CollisionShape2D = $CollisionShape2D

signal health_changed(new_health)
signal super_changed(new_meter)
signal died
signal attack_landed

func _ready():
	current_health = max_health
	hitbox.monitoring = false
	# Hitbox detects entering hurtboxes (collision_layer=0, collision_mask=2)
	# When hitbox overlaps something on layer 2 (an enemy hurtbox), signal fires
	hitbox.area_entered.connect(_on_hitbox_hit)

func _physics_process(delta):
	if is_dead:
		return
	
	# Always apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Don't allow movement during hitstun or attacks (handled in subclass)
	if is_hit:
		# Still apply friction during hitstun
		velocity.x = move_toward(velocity.x, 0, move_speed * 4.0)
		move_and_slide()
		return
	
	if is_attacking:
		move_and_slide()
		return
	
	# Friction on ground
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0, move_speed * 2.0)
	
	move_and_slide()
	update_animation()

func update_animation():
	if is_hit or is_dead:
		return
	if not is_on_floor():
		play_anim("jump")
	elif velocity.x != 0:
		play_anim("walk")
	else:
		play_anim("idle")

func play_anim(anim_name: String):
	if animation_player and animation_player.has_animation(anim_name):
		if animation_player.current_animation != anim_name:
			animation_player.play(anim_name)

func take_damage(amount: int, knockback_dir: float = 1.0):
	if is_dead:
		return
	if is_blocking:
		amount = int(amount * 0.3)
	
	current_health = max(0, current_health - amount)
	emit_signal("health_changed", current_health)
	
	if current_health <= 0:
		die()
	else:
		is_hit = true
		velocity.x = knockback_dir * 300.0
		velocity.y = -200.0
		play_anim("hit")
		await get_tree().create_timer(0.35).timeout
		is_hit = false

func gain_super(amount: float):
	super_meter = min(super_meter + amount, 100.0)
	emit_signal("super_changed", super_meter)

func die():
	is_dead = true
	play_anim("die")
	emit_signal("died")
	await get_tree().create_timer(1.0).timeout
	queue_free()

func flip_direction():
	is_facing_right = !is_facing_right
	sprite.flip_h = !sprite.flip_h
	# Flip hitbox side based on facing direction
	hitbox.position.x = abs(hitbox.position.x) * (-1 if is_facing_right else 1)

func perform_attack(attack_type: String, damage: int, duration: float):
	if is_hit or is_dead:
		return
	is_attacking = true
	attack_damage = damage
	combo_count += 1
	hitbox.monitoring = true
	play_anim(attack_type)
	gain_super(super_gain_rate)
	
	await get_tree().create_timer(duration).timeout
	hitbox.monitoring = false
	is_attacking = false

func perform_special():
	pass # Override by subclasses

func perform_super():
	if super_meter >= 100:
		super_meter = 0
		emit_signal("super_changed", super_meter)
		is_attacking = true
		play_anim("super")
		await get_tree().create_timer(1.0).timeout
		is_attacking = false

# Called when OUR hitbox enters an enemy area (their hurtbox is on collision_layer 2)
func _on_hitbox_hit(area: Area2D):
	# area is the enemy's hurtbox
	if area == hurtbox:
		return  # Ignore self
	if not area.get_parent():
		return
	
	var enemy = area.get_parent()
	# Check if this area belongs to an enemy (not ourselves)
	if enemy == self:
		return
	
	# The enemy's hurtbox was hit by our hitbox
	# Call take_damage on the enemy
	if enemy.has_method("take_damage"):
		var kb = 180.0 if is_facing_right else -180.0
		enemy.take_damage(attack_damage, kb)
		emit_signal("attack_landed")
		gain_super(super_gain_rate * 1.5)

func get_damage() -> int:
	return attack_damage
